require "spec_helper"

describe PrizzmInvitationsController do
  describe "routing" do

    it "routes to #index" do
      get("/prizzm_invitations").should route_to("prizzm_invitations#index")
    end

    it "routes to #new" do
      get("/prizzm_invitations/new").should route_to("prizzm_invitations#new")
    end

    it "routes to #show" do
      get("/prizzm_invitations/1").should route_to("prizzm_invitations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/prizzm_invitations/1/edit").should route_to("prizzm_invitations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/prizzm_invitations").should route_to("prizzm_invitations#create")
    end

    it "routes to #update" do
      put("/prizzm_invitations/1").should route_to("prizzm_invitations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/prizzm_invitations/1").should route_to("prizzm_invitations#destroy", :id => "1")
    end

  end
end
