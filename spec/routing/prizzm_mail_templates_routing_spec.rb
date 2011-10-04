require "spec_helper"

describe PrizzmMailTemplatesController do
  describe "routing" do

    it "routes to #index" do
      get("/prizzm_mail_templates").should route_to("prizzm_mail_templates#index")
    end

    it "routes to #new" do
      get("/prizzm_mail_templates/new").should route_to("prizzm_mail_templates#new")
    end

    it "routes to #show" do
      get("/prizzm_mail_templates/1").should route_to("prizzm_mail_templates#show", :id => "1")
    end

    it "routes to #edit" do
      get("/prizzm_mail_templates/1/edit").should route_to("prizzm_mail_templates#edit", :id => "1")
    end

    it "routes to #create" do
      post("/prizzm_mail_templates").should route_to("prizzm_mail_templates#create")
    end

    it "routes to #update" do
      put("/prizzm_mail_templates/1").should route_to("prizzm_mail_templates#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/prizzm_mail_templates/1").should route_to("prizzm_mail_templates#destroy", :id => "1")
    end

  end
end
