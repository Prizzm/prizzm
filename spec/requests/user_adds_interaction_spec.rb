require 'spec_helper'

describe "A User adding an Interaction" do
  before do
    @user = Factory :user
    @item = Factory :item
    @user.items << @item
  end

  describe "when looking at an Item detail page" do
    it "should be able to add an interaction for that Item" do
      sign_in_and_view_item
      page.should have_content "ITEM DETAILS - #{@item.name}"
      fill_in "interaction-input", :with  => "My Interaction"
      click_button "Save"
      page.should have_content "My Interaction"
    end
  end
end
