require 'spec_helper'

describe "companies/show.html.haml" do
  before(:each) do
    @company = assign(:company, stub_model(Company,
      :email => "Email",
      :address => "Address",
      :phone_number => "Phone Number",
      :secondary_number => "Secondary Number",
      :url => "MyText",
      :industry => "Industry",
      :contact_name => "Contact Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Address/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Phone Number/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Secondary Number/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Industry/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Contact Name/)
  end
end
