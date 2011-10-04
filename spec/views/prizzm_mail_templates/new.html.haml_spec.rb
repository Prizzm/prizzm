require 'spec_helper'

describe "prizzm_mail_templates/new.html.haml" do
  before(:each) do
    assign(:prizzm_mail_template, stub_model(PrizzmMailTemplate).as_new_record)
  end

  it "renders new prizzm_mail_template form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => prizzm_mail_templates_path, :method => "post" do
    end
  end
end
