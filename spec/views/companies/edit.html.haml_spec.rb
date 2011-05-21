require 'spec_helper'

describe "companies/edit.html.haml" do
  before(:each) do
    @company = assign(:company, stub_model(Company,
      :email => "MyString",
      :address => "MyString",
      :phone_number => "MyString",
      :secondary_number => "MyString",
      :url => "MyText",
      :industry => "MyString",
      :contact_name => "MyString"
    ))
  end

  it "renders the edit company form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => companies_path(@company), :method => "post" do
      assert_select "input#company_email", :name => "company[email]"
      assert_select "input#company_address", :name => "company[address]"
      assert_select "input#company_phone_number", :name => "company[phone_number]"
      assert_select "input#company_secondary_number", :name => "company[secondary_number]"
      assert_select "textarea#company_url", :name => "company[url]"
      assert_select "input#company_industry", :name => "company[industry]"
      assert_select "input#company_contact_name", :name => "company[contact_name]"
    end
  end
end
