require 'spec_helper'

describe "interactions/edit.html.haml" do
  before(:each) do
    @interaction = assign(:interaction, stub_model(Interaction))
  end

  it "renders the edit interaction form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => interactions_path(@interaction), :method => "post" do
    end
  end
end
