require 'spec_helper'

describe "items/index.html.haml" do
  before(:each) do
    assign(:items, [
      stub_model(Item),
      stub_model(Item)
    ])
  end

  it "renders a list of items" do
    render
  end
end
