require 'spec_helper'

describe "products/edit.html.haml" do
  before(:each) do
    @product = assign(:product, stub_model(Product,
      :namee => "MyString",
      :type => "MyString",
      :upc => "MyString"
    ))
  end

  it "renders the edit product form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => products_path(@product), :method => "post" do
      assert_select "input#product_namee", :name => "product[namee]"
      assert_select "input#product_type", :name => "product[type]"
      assert_select "input#product_upc", :name => "product[upc]"
    end
  end
end
