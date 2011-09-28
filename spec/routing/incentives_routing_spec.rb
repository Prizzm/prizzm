require "spec_helper"

describe IncentivesController do
  describe "routing" do

    it "routes to #index" do
      get("/incentives").should route_to("incentives#index")
    end

    it "routes to #new" do
      get("/incentives/new").should route_to("incentives#new")
    end

    it "routes to #show" do
      get("/incentives/1").should route_to("incentives#show", :id => "1")
    end

    it "routes to #edit" do
      get("/incentives/1/edit").should route_to("incentives#edit", :id => "1")
    end

    it "routes to #create" do
      post("/incentives").should route_to("incentives#create")
    end

    it "routes to #update" do
      put("/incentives/1").should route_to("incentives#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/incentives/1").should route_to("incentives#destroy", :id => "1")
    end

  end
end
