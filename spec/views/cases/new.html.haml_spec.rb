require 'spec_helper'

describe "cases/new.html.haml" do
  before(:each) do
    assign(:case, stub_model(Case,
      :title => "MyString",
      :description => "MyText",
      :case_reference => "MyString",
      :user => nil,
      :company => nil,
      :item => nil
    ).as_new_record)
  end

  it "renders new case form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cases_path, :method => "post" do
      assert_select "input#case_title", :name => "case[title]"
      assert_select "textarea#case_description", :name => "case[description]"
      assert_select "input#case_case_reference", :name => "case[case_reference]"
      assert_select "input#case_user", :name => "case[user]"
      assert_select "input#case_company", :name => "case[company]"
      assert_select "input#case_item", :name => "case[item]"
    end
  end
end
