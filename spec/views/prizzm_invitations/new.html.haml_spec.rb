require 'spec_helper'

describe "prizzm_invitations/new.html.haml" do
  before(:each) do
    assign(:prizzm_invitation, stub_model(PrizzmInvitation).as_new_record)
  end

  it "renders new prizzm_invitation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => prizzm_invitations_path, :method => "post" do
    end
  end
end
