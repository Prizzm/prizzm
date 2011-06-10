shared_examples_for "a user is logged in" do
  before :all do
  end


  before :each do
    @user = Factory :user
    visit root_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
    click_button"Log in"
    @page = page
  end
end
