require 'rails_helper'

RSpec.describe "manufacturers/new", :type => :view do
  before(:each) do
    assign(:manufacturer, Manufacturer.new())
  end

  it "renders new manufacturer form" do
    render

    assert_select "form[action=?][method=?]", manufacturers_path, "post" do
    end
  end
end
