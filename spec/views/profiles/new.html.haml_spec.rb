require 'spec_helper'

describe "profiles/new.html.haml" do
  before(:each) do
    assign(:profile, stub_model(Profile,
      :first_name => "MyString",
      :last_name => "MyString",
      :phone_number => "MyString",
      :location => "MyString",
      :user => nil
    ).as_new_record)
  end

  it "renders new profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => profiles_path, :method => "post" do
      assert_select "input#profile_first_name", :name => "profile[first_name]"
      assert_select "input#profile_last_name", :name => "profile[last_name]"
      assert_select "input#profile_phone_number", :name => "profile[phone_number]"
      assert_select "input#profile_location", :name => "profile[location]"
      assert_select "input#profile_user", :name => "profile[user]"
    end
  end
end
