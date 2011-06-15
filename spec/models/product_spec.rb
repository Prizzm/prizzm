require 'spec_helper'

describe Product do
  describe "model attributes" do
    it {should have_db_column(:name).of_type(:string)}
    it {should have_db_column(:product_type).of_type(:string)}
    it {should have_db_column(:upc).of_type(:string)}
    it {should have_db_column(:price).of_type(:string)}
    it {should have_db_column(:url).of_type(:text)}
    it {should have_db_column(:description).of_type(:text)}
    it {should have_db_column(:rating).of_type(:integer)}
  end

  describe "associations" do
    it {should belong_to(:company)}
    it {should have_many(:images)}
    it {should have_many(:images).dependent(:destroy)}
    it {should have_many(:items)}
    it {should have_many(:items).dependent(:nullify)}
    it {should have_many(:users).through(:items)}
  end
end



