require 'rails_helper'

RSpec.describe "products/index", :type => :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        :name => "Name",
        :model => "Model",
        :quantity => 1,
        :viewed => 2,
        :image => "Image",
        :price => "9.99",
        :points => 3,
        :description => "MyText"
      ),
      Product.create!(
        :name => "Name",
        :model => "Model",
        :quantity => 1,
        :viewed => 2,
        :image => "Image",
        :price => "9.99",
        :points => 3,
        :description => "MyText"
      )
    ])
  end

  it "renders a list of products" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Model".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
