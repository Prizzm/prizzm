require "spec_helper"

describe ProductsController do
  describe "routing" do

    it "should provide a friendly URL for recipients of the product invitations" do
      friendly_url = '/invitation/1'
      get(friendly_url).should route_to("product_invitations#view_invitation")
    end
  end
end
