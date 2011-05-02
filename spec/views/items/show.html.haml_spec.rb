require 'spec_helper'

describe "items/show.html.haml" do
  before(:each) do
    @item = assign(:item, stub_model(Item))
  end

  it "renders attributes in <p>" do
    render
  end
end
