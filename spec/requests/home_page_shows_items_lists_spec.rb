require 'spec_helper'

describe "Home page shows lists Users's Items" do
  before do
    @user = Factory :user
  end

  describe "visits home page" do
    it "should show the login form" do
      visit root_path
      page.should have_field "Email"
      page.should have_field "Password"
    end

    it "should allow the user to log in through the form" do
      visit root_path
      fill_in "Email", :with => @user.email
      fill_in "Password", :with => @user.password
      click_button"Log in"
      page.should have_content "Signed in successfully."
    end
  end

  context "and signs in" do
    it "should should a list of the users items" do
      sign_in
      page.should have_content "Things I Have"
    end
  end

  context "and wants to add a new item" do

    it "should allow the user to add a new item" do
      sign_in
      click_link "add-item-link"
    end
  end
end
