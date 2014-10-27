require 'rails_helper'

RSpec.describe "manufacturers/index", :type => :view do
  before(:each) do
    assign(:manufacturers, [
      Manufacturer.create!(),
      Manufacturer.create!()
    ])
  end

  it "renders a list of manufacturers" do
    render
  end
end
