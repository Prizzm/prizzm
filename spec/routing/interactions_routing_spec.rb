require "spec_helper"

describe InteractionsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/interactions" }.should route_to(:controller => "interactions", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/interactions/new" }.should route_to(:controller => "interactions", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/interactions/1" }.should route_to(:controller => "interactions", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/interactions/1/edit" }.should route_to(:controller => "interactions", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/interactions" }.should route_to(:controller => "interactions", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/interactions/1" }.should route_to(:controller => "interactions", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/interactions/1" }.should route_to(:controller => "interactions", :action => "destroy", :id => "1")
    end

  end
end
