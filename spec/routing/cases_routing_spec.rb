require "spec_helper"

describe CasesController do
  describe "routing" do

    it "routes to #index" do
      get("/cases").should route_to("cases#index")
    end

    it "routes to #new" do
      get("/cases/new").should route_to("cases#new")
    end

    it "routes to #show" do
      get("/cases/1").should route_to("cases#show", :id => "1")
    end

    it "routes to #edit" do
      get("/cases/1/edit").should route_to("cases#edit", :id => "1")
    end

    it "routes to #create" do
      post("/cases").should route_to("cases#create")
    end

    it "routes to #update" do
      put("/cases/1").should route_to("cases#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/cases/1").should route_to("cases#destroy", :id => "1")
    end

  end
end
