class ImagesController < ApplicationController

  def index
  end

  def new
  end

  def success

    @image_name =  params[:image]

    @folder_name =  params[:folder]
    
    begin

      #Create directory with user input
      Dir.mkdir( 'app/assets/images/' + @folder_name.to_s )

      File.open( Rails.root.join('app/assets/images/' + @folder_name.to_s , @image_name.original_filename ), 'wb') do |file|
        
      #Put image into created directory
      file.write( @image_name.read )

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