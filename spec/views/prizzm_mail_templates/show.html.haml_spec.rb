require 'spec_helper'

describe "prizzm_mail_templates/show.html.haml" do
  before(:each) do
    @prizzm_mail_template = assign(:prizzm_mail_template, stub_model(PrizzmMailTemplate))
  end

  it "renders attributes in <p>" do
    render
  end
end
