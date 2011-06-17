require 'spec_helper'

describe ItemImage do
  describe "model attributes" do
    it {should have_db_column(:image).of_type(:string)}
  end

  describe "associations" do
    it {should belong_to(:item)}
  end
end

describe "Item image handling" do
  context "when uploading images" do
    subject {Factory :item} 

    describe "that come from a URL" do
      it "should be able to add an image from a URL it has an extension" do
        expect {subject.add_image_from_url "http://www.google.com/images/logos/ps_logo2.png"}.to change(subject.images, :count).by(1)
      end

      # There is a bug in ImageMagick.  It uses the file extension to
      # determine thw filetype, and thus how to process the image.  If no
      # extension is provided, it throws the error "no encode delegate for this
      # image format".  As carrierwave uses ImageMagick, it bugs when we try
      # to process files with no extension.. (weather from URL or Local).  
      # The solution would be to detect the file.content_type, and then
      # rename the file accordingly, providing an extension before processing
      # it.  I haven't been able to successfully hack Carrierwave to do this.
      it "should be able to add an image from a URL it does not have an extension" do
        pending "Bug in Carrierwave/ImmageMagick"
        expect {subject.add_image_from_url "http://lorempixum.com/600/600"}.to change(subject.images, :count).by(1)
      end
    end

    # We assume that the filetypes are rerstricted by extension on the client
    # side
    it "should be able to add an image from a file" do
      image_data = File.open(Rails.root.join('spec/fixtures/test-image.png'))
      expect {subject.add_image_from_file image_data}.to change(subject.images, :count).by(1)
    end
  end

  describe "once uploaded" do
    describe "using the :fog backend" do
      subject {Factory :item_with_images} 

      # This test only passes beecause the S3 host is specified in the url.
      # When using CarrierWave :file storage, the host isn't specified and it
      # fails
      it "should be accessible from a URL" do
        image_url = subject.images.first.image.url
        rest_response(image_url).code.should eq(200)
      end
    end

    describe "using the :file backend" do
      subject {Factory :item_with_images} 

      # This test fails for the reason above
      it "should be accessible from a URL" do
        pending "switch storage backends in the test, and verify"
        image_url = subject.images.first.image.url
        rest_response(image_url).code.should eq(200)
      end
    end

  end

  describe "when deleting images" do
    subject {Factory :item_with_images} 

    it "should remove images from the server when they are deleted" do
      image_url = subject.images.last.image.url
      rest_response(image_url).code.should eq(200)
      subject.images.last.destroy
      rest_response(image_url).code.should eq(403)
    end
  end
end
