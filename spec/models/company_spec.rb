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
end
