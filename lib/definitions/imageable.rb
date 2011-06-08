module Imageable

  def add_image_from_url url
    self.images.create(:remote_image_url => url)
  end 

  def add_image_from_file image_data
    self.images.create(image_data)
  end
end
