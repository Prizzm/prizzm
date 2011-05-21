require 'spec_helper'

describe "products/index.html.haml" do
  before(:each) do
    assign(:products, [
      stub_model(Product,
        :namee => "Namee",
        :type => "Type",
        :upc => "Upc"
      ),
      stub_model(Product,
        :namee => "Namee",
        :type => "Type",
        :upc => "Upc"
      )
    ])
  end

  it "renders a list of products" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Namee".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Upc".to_s, :count => 2
  end
end
