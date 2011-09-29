require 'spec_helper'

describe "incentives/new.html.haml" do
  before(:each) do
    assign(:incentive, stub_model(Incentive,
      :company => nil,
      :description => "MyText",
      :code => "MyString"
    ).as_new_record)
  end

  it "renders new incentive form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => incentives_path, :method => "post" do
      assert_select "input#incentive_company", :name => "incentive[company]"
      assert_select "textarea#incentive_description", :name => "incentive[description]"
      assert_select "input#incentive_code", :name => "incentive[code]"
    end
  end
end
