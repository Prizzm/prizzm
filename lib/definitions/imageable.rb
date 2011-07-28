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
    images.first.image.url
  end

  def main_image_thumb
    images.first.image.thumb.url
  end
end
