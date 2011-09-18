require 'spec_helper'

describe "clients/index.html.haml" do
  before(:each) do
    assign(:clients, [
      stub_model(Client,
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email",
        :user => nil,
        :company => nil
      ),
      stub_model(Client,
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email",
        :user => nil,
        :company => nil
      )
    ])
  end

  it "renders a list of clients" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
