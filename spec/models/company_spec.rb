require 'spec_helper'

describe Company do

  describe "model attributes" do
    it {should have_db_column(:email).of_type(:string)}
    it {should have_db_column(:address).of_type(:string)}
    it {should have_db_column(:phone_number).of_type(:string)}
    it {should have_db_column(:secondary_number).of_type(:string)}
    it {should have_db_column(:industry).of_type(:string)}
    it {should have_db_column(:contact_name).of_type(:string)}
    it {should have_db_column(:url).of_type(:text)}
  end

  describe "associations" do
    it {should have_many(:products)}
    it {should have_many(:products).dependent(:nullify)}
    it {should have_many(:images)}
    it {should have_many(:images).dependent(:destroy)}
  end

  context "images" do
    context "when uploading images" do
      subject {Factory :company} 

      describe "that come from a URL" do
        it "should be able to add an image from a URL it has an extension" do
          expect {subject.add_image_from_url "http://www.google.com/images/logos/ps_logo2.png"}.to change(subject.images, :count).from(0).to(1)
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
          expect {subject.add_image_from_url "http://lorempixum.com/600/600"}.to change(subject.images, :count).from(0).to(1)
        end
      end
 
      # We assume that the filetypes are rerstricted by extension on the client
      # side
      it "should be able to add an image from a file" do
        image_data = File.open(Rails.root.join('spec/fixtures/test-image.png'))
        expect {subject.add_image_from_file image_data}.to change(subject.images, :count).from(0).to(1)
      end
    end

    describe "once uploaded" do
      subject {Factory :company_with_images} 

      it "should be accessible from a URL" do
        image_url = subject.images.first.image.url
        get image_url
        response.should be_success
      end
    end
 
    describe "when deleting images" do
      subject {Factory :company_with_images} 

      it "should remove images from the server when they are deleted", :long_term => true do
      end
    end
  end
end
