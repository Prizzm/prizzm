
def sign_in
  visit root_path
  fill_in "Email", :with => @user.email
  fill_in "Password", :with => @user.password
  click_button"Log in"
end

def goto_item_page
  click_link @user.items.first.name
end 

def sign_in_and_view_item
  sign_in
  goto_item_page
end 
