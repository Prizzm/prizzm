require 'spec_helper'

describe "clients/new.html.haml" do
  before(:each) do
    assign(:client, stub_model(Client,
      :first_name => "MyString",
      :last_name => "MyString",
      :email => "MyString",
      :user => nil,
      :company => nil
    ).as_new_record)
  end

  it "renders new client form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => clients_path, :method => "post" do
      assert_select "input#client_first_name", :name => "client[first_name]"
      assert_select "input#client_last_name", :name => "client[last_name]"
      assert_select "input#client_email", :name => "client[email]"
      assert_select "input#client_user", :name => "client[user]"
      assert_select "input#client_company", :name => "client[company]"
    end
  end
end
