class ImagesController < ApplicationController
  def new
  end
  
  def uploadFile
    new_image = Image.create(url: 'aaa')
    new_image.save_file(params[:picture])
    render :text => new_image.url + "!" + "File has been uploaded successfully"
  end

end
