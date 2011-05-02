require 'spec_helper'

describe "interactions/show.html.haml" do
  before(:each) do
    @interaction = assign(:interaction, stub_model(Interaction))
  end

  it "renders attributes in <p>" do
    render
  end
end
