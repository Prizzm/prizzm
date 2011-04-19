require 'spec_helper'

describe "interactions/index.html.haml" do
  before(:each) do
    assign(:interactions, [
      stub_model(Interaction),
      stub_model(Interaction)
    ])
  end

  it "renders a list of interactions" do
    render
  end
end
