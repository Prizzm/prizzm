require 'spec_helper'

describe "interactions/new.html.haml" do
  before(:each) do
    assign(:interaction, stub_model(Interaction).as_new_record)
  end

  it "renders new interaction form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => interactions_path, :method => "post" do
    end
  end
end
