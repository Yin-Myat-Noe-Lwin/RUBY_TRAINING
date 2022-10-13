class ImagesController < ApplicationController

  def index
  end

  def new
  end

  def success

    @image =  params[:image]

    @folder =  params[:folder]

    @extension = File.extname(@image)

    if @extension.to_s == ".jpg" || @extension.to_s == ".png"

      begin

        #Create directory with user input
        Dir.mkdir( 'app/assets/images/' + @folder.to_s )

        File.open( Rails.root.join('app/assets/images/' + @folder.to_s , @image.original_filename ), 'wb') do |file|
          
        #Put image into created directory
        file.write( @image.read )

        end

      rescue Exception=>e

        #show flash message if folder name already exists
        flash.alert = "Failed to save image. Folder name already exists."

        redirect_to fail_url

      end

  else

    #show flash message if input file is not image
    flash.alert = "Unsupported File Type"

      redirect_to fail_url

  end

  end

  def fail
  end

end