require 'spec_helper'
require 'selenium-webdriver'

#page.driver.browser

shared_context "a valid user exists" do
  def create_user
    @user = Factory :user
    @user.make_real
  end

  def login user
    fill_in "Email", :with => user.email
    fill_in "Password", :with  => user.password
    click_button "Sign in"
  end

  before {create_user}
  let(:user) { @user }

end

describe "The site" do
  include_context "a valid user exists"
  
  
  context "concerning user logins" do
    before { visit new_user_session_path }

    it "should not allow a user to sign in with bad credentials" do 
      fill_in "Email", :with => ""
      fill_in "Password", :with  => ""
      click_button "Sign in"
      page.should have_content "Invalid email or password."
    end 

    it "should sign in with good credentials" do 
      login user
      page.should have_content "Signed in successfully."
    end 
  end

  describe "once a user has logged in" do
    before do
      visit new_user_session_path
      login user
    end
    
    context "should do basic things" do
      it "should welcome the user by saying Hello" do
        page.should have_content "Hello #{user.email}"
      end
    end

    context "and wants to add things" do
      xit "should allow the user to add a new item", :js => true  do 
        click_link "add-item-link"
        page.should have_content "Add an Item"
        item = Factory.build :item
        fill_in "item_name", :with => item.name
        fill_in "item_url", :with => item.url
        fill_in "item_description", :with => item.description
        fill_in "item_itemtype", :with => item.itemtype
        click_button "item_submit"
        page.should have_content "Item was successfully created."
        page.should have_content item.name
        page.should have_content item.url
        page.should have_content item.description
        page.should have_content item.itemtype
      end 
    end

    context "and wants to edit in place" do
      xit "should edit the user phone number in place", :js => true do
        page.should have_content user.phone_number
        new_user_phone_number = "+33 1 45 41 57 00"
        find("#best_in_place_user_1_phone_number").click
        find(:xpath, "form[@class='form_in_place']/input").set new_user_phone_number
        locate(:xpath, "form[@class='form_in_place']/input").node.send_keys :enter
        locate(:xpath, "//form[@class='form_in_place']/input").node.send_string_of_keys :enter
        page.should have_content new_user_phone_number
      end

      xit "should edit the user email in place", :js => true do
        page.should have_content user.email
        new_user_email = "changed@email.com"
        find("best_in_place_user_1_email").click
        find("form[@class='form_in_place']/input").set new_user_email
        locate(:xpath, "form[@class='form_in_place']/input").node.send_keys :enter
        page.evaluate_script("document.forms[0].submit()")
        page.should have_content new_user_email
      end
    end

  end
end
