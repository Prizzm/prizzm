require 'spec_helper'

describe "cases/index.html.haml" do
  before(:each) do
    assign(:cases, [
      stub_model(Case,
        :title => "Title",
        :description => "MyText",
        :case_reference => "Case Reference",
        :user => nil,
        :company => nil,
        :item => nil
      ),
      stub_model(Case,
        :title => "Title",
        :description => "MyText",
        :case_reference => "Case Reference",
        :user => nil,
        :company => nil,
        :item => nil
      )
    ])
  end

  it "renders a list of cases" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Case Reference".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
