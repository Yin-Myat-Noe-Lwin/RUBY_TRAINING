class ImagesController < ApplicationController

  def index
  end

  def new
  end

  def success

    @image =  params[:image]

    @folder =  params[:folder]
    
    begin

      #Create directory with user input
      Dir.mkdir( 'app/assets/images/' + @folder.to_s )

      File.open( Rails.root.join('app/assets/images/' + @folder.to_s , @image.original_filename ), 'wb') do |file|
        
      #Put image into created directory
      file.write( @image.read )

      end

    rescue Exception=>e

      #show flash message if folder name already exist
      flash.alert = "Failed to save image. Folder name already exists."

      redirect_to fail_url

    end

  end

  def fail
  end

end