require 'spec_helper'

describe "incentives/index.html.haml" do
  before(:each) do
    assign(:incentives, [
      stub_model(Incentive,
        :company => nil,
        :description => "MyText",
        :code => "Code"
      ),
      stub_model(Incentive,
        :company => nil,
        :description => "MyText",
        :code => "Code"
      )
    ])
  end

  it "renders a list of incentives" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Code".to_s, :count => 2
  end
end
