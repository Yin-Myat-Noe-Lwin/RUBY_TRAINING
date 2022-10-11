class FilesController < ApplicationController

  require 'rubygems'
  require 'fileutils'
  require 'roo'
  require 'csv'
  require 'docx'

  def read
  end

  def show
  
    @file_data = params[:file]

    @extension = File.extname(@file_data)

    case @extension.to_s

    when '.txt'

      @contents = File.read(@file_data)

    when '.xlsx'

      @xlsx = Roo::Spreadsheet.open(@file_data)

      @row= 1

      @contents=[]

      @xlsx.each_row_streaming do |row|

        @data = @xlsx.row(@row)

        @contents.push @data

        @row = @row +1 

      end
   
    when '.csv'

      @contents=CSV.read(@file_data)

    when '.docx'

      @data = params[:file].original_filename

      @tmp = params[:file].tempfile

      @file = File.join("public", params[:file].original_filename)

      FileUtils.cp @tmp.path, @file

      @contents=Docx::Document.open("public/" + @data  )

    else

      @contents = "Unsupported File Type"

    end
  
  end

end