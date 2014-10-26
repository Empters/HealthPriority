require 'rails_helper'

RSpec.describe "product_discounts/show", :type => :view do
  before(:each) do
    @product_discount = assign(:product_discount, ProductDiscount.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
