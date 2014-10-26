require 'rails_helper'

RSpec.describe "product_discounts/edit", :type => :view do
  before(:each) do
    @product_discount = assign(:product_discount, ProductDiscount.create!())
  end

  it "renders the edit product_discount form" do
    render

    assert_select "form[action=?][method=?]", product_discount_path(@product_discount), "post" do
    end
  end
end
