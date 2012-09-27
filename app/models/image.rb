class Image < ActiveRecord::Base
  attr_accessible :name, :url
  belongs_to :imageable, :polymorphic => true
  
  def save_file(upload)
    current_time_string = Time.now.strftime('%Y-%m-%d')
    directory = self.create_save_directory_and_get_name(current_time_string)
    file_name = upload.original_filename
    self.set_url(current_time_string, file_name)
    full_name = File.join(directory, file_name)
    File.open(full_name, "wb") { |f| f.write(upload.read) }
  end
  
  def create_save_directory_and_get_name(current_time_string)
    directory = 'public/costume_pictures/' + current_time_string
    FileUtils.mkdir_p(directory)
    directory
  end
  
  def set_url(current_time_string, file_name)
    self.url = "/costume_pictures/" + current_time_string + "/" + file_name
    self.save
  end
end
