require 'spec_helper'

describe "products/show.html.haml" do
  before(:each) do
    @product = assign(:product, stub_model(Product,
      :namee => "Namee",
      :type => "Type",
      :upc => "Upc"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Namee/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Type/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Upc/)
  end
end
