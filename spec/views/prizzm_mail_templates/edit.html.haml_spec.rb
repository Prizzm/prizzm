require 'spec_helper'

describe "prizzm_mail_templates/edit.html.haml" do
  before(:each) do
    @prizzm_mail_template = assign(:prizzm_mail_template, stub_model(PrizzmMailTemplate))
  end

  it "renders the edit prizzm_mail_template form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => prizzm_mail_templates_path(@prizzm_mail_template), :method => "post" do
    end
  end
end
