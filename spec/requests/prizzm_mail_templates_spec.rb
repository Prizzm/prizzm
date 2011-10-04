require 'spec_helper'

describe "PrizzmMailTemplates" do
  describe "GET /prizzm_mail_templates" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get prizzm_mail_templates_path
      response.status.should be(200)
    end
  end
end
