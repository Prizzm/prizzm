require 'spec_helper'

describe "prizzm_invitations/edit.html.haml" do
  before(:each) do
    @prizzm_invitation = assign(:prizzm_invitation, stub_model(PrizzmInvitation))
  end

  it "renders the edit prizzm_invitation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => prizzm_invitations_path(@prizzm_invitation), :method => "post" do
    end
  end
end
