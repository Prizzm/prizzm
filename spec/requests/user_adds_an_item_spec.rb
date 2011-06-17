require 'spec_helper'

describe "User adds an Item" do
  before do
    @user = Factory :user
  end

  context "and wants to add a new item from the home page" do
    it "should allow the user to add a new item" do
      sign_in
      click_link "add-item-link"
      new_item = Factory.build :item
      fill_in "Name", :with => new_item.name
      fill_in "Review", :with => new_item.review
      click_on "Create Item"
      page.should have_content "Item was successfully created."
      page.should have_content new_item.name
    end

    it "should autosuggest products to associate the item with" do
    end

    it "should " do
    end
    
  end
end
