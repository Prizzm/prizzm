require 'spec_helper'

describe "incentives/edit.html.haml" do
  before(:each) do
    @incentive = assign(:incentive, stub_model(Incentive,
      :company => nil,
      :description => "MyText",
      :code => "MyString"
    ))
  end

  it "renders the edit incentive form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => incentives_path(@incentive), :method => "post" do
      assert_select "input#incentive_company", :name => "incentive[company]"
      assert_select "textarea#incentive_description", :name => "incentive[description]"
      assert_select "input#incentive_code", :name => "incentive[code]"
    end
  end
end
