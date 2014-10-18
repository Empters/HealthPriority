require 'rails_helper'

RSpec.describe "manufacturers/show", :type => :view do
  before(:each) do
    @manufacturer = assign(:manufacturer, Manufacturer.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
