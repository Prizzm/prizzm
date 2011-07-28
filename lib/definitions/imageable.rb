module Imageable

  def add_image_from_url url
    self.images.create(:remote_image_url => url)
  end 

  def add_image_from_file image_data
    self.images.create(image_data)
  end

  def add_image_from_path path
    image = File.open(path)
    new_image = self.images.create
    new_image.image.store! image
    new_image.save!
  end

  def main_image
    begin
      images.first.image.url 
    rescue
      "default-missing-image.jpg" 
    end
  end

  def main_image_thumb
    begin
      images.first.image.thumb.url
    rescue
      "default-missing-image-thumb.jpg" 
    end
  end
end
