require 'spec_helper'

describe "prizzm_mail_templates/index.html.haml" do
  before(:each) do
    assign(:prizzm_mail_templates, [
      stub_model(PrizzmMailTemplate),
      stub_model(PrizzmMailTemplate)
    ])
  end

  it "renders a list of prizzm_mail_templates" do
    render
  end
end
