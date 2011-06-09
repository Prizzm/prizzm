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

    end
  end
end
