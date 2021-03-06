require 'rails_helper'

RSpec.describe "products/edit", :type => :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      :name => "MyString",
      :model => "MyString",
      :quantity => 1,
      :viewed => 1,
      :image => "MyString",
      :price => "9.99",
      :points => 1,
      :description => "MyText"
    ))
  end

  it "renders the edit product form" do
    render

    assert_select "form[action=?][method=?]", product_path(@product), "post" do

      assert_select "input#product_name[name=?]", "product[name]"

      assert_select "input#product_model[name=?]", "product[model]"

      assert_select "input#product_quantity[name=?]", "product[quantity]"

      assert_select "input#product_viewed[name=?]", "product[viewed]"

      assert_select "input#product_image[name=?]", "product[image]"

      assert_select "input#product_price[name=?]", "product[price]"

      assert_select "input#product_points[name=?]", "product[points]"

      assert_select "textarea#product_description[name=?]", "product[description]"
    end
  end
end
