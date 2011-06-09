require 'spec_helper'

describe Interaction do
  describe "model attributes" do
    it {should have_db_column(:review).of_type(:text)}
    it {should have_db_column(:rating).of_type(:integer)}
  end

  describe "associations" do
    it {should belong_to(:item)}
    it {should belong_to(:user)}
    it {should have_many(:images)}
    it {should have_many(:images).dependent(:destroy)}
    it {should have_many(:interactions)}
    it {should have_many(:interactions).dependent(:destroy)}
  end
end
