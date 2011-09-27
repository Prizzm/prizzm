require 'spec_helper'

describe "prizzm_invitations/index.html.haml" do
  before(:each) do
    assign(:prizzm_invitations, [
      stub_model(PrizzmInvitation),
      stub_model(PrizzmInvitation)
    ])
  end

  it "renders a list of prizzm_invitations" do
    render
  end
end
