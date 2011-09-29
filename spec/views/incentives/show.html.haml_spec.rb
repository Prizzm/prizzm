require 'spec_helper'

describe "incentives/show.html.haml" do
  before(:each) do
    @incentive = assign(:incentive, stub_model(Incentive,
      :company => nil,
      :description => "MyText",
      :code => "Code"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Code/)
  end
end
