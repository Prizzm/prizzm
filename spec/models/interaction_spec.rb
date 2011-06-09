require 'spec_helper'

describe Interaction do
  describe "model attributes" do
    it {should have_db_column(:description).of_type(:text)}
    it {should have_db_column(:rating).of_type(:integer)}
  end

  describe "associations" do
    it {should belong_to(:item)}
  end
end
