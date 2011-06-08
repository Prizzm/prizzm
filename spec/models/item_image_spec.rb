require 'spec_helper'

describe ItemImage do
  describe "model attributes" do
    it {should have_db_column(:image).of_type(:string)}
  end

  describe "associations" do
    it {should belong_to(:item)}
  end
end
