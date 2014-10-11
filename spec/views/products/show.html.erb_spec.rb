require 'rails_helper'

RSpec.describe "products/show", :type => :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      :name => "Name",
      :model => "Model",
      :quantity => 1,
      :viewed => 2,
      :image => "Image",
      :price => "9.99",
      :points => 3,
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Model/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Image/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/MyText/)
  end
end
