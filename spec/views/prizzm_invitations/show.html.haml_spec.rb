require 'spec_helper'

describe "prizzm_invitations/show.html.haml" do
  before(:each) do
    @prizzm_invitation = assign(:prizzm_invitation, stub_model(PrizzmInvitation))
  end

  it "renders attributes in <p>" do
    render
  end
end
