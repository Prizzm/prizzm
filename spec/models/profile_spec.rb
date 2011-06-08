require 'spec_helper'

describe Profile do
  describe "model attributes" do
    it {should have_db_column(:first_name).of_type(:string)}
    it {should have_db_column(:last_name).of_type(:string)}
    it {should have_db_column(:phone_number).of_type(:string)}
    it {should have_db_column(:photo).of_type(:string)}
    it {should have_db_column(:location).of_type(:string)}
  end

  describe "associations" do
    it {should belong_to(:user)}
  end
end



