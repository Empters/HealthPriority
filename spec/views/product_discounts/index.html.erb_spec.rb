require 'rails_helper'

RSpec.describe "product_discounts/index", :type => :view do
  before(:each) do
    assign(:product_discounts, [
      ProductDiscount.create!(),
      ProductDiscount.create!()
    ])
  end

  it "renders a list of product_discounts" do
    render
  end
end
