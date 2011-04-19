require 'spec_helper'

describe RegistrationsController do

  describe "GET 'update'" do
    it "should be successful" do
      get 'update'
      response.should be_success
    end
  end

end
