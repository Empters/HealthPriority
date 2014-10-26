require 'rails_helper'

RSpec.describe "product_discounts/new", :type => :view do
  before(:each) do
    assign(:product_discount, ProductDiscount.new())
  end

  it "renders new product_discount form" do
    render

    assert_select "form[action=?][method=?]", product_discounts_path, "post" do
    end
  end
end
