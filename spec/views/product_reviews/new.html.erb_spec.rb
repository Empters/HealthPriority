require 'rails_helper'

RSpec.describe "product_reviews/new", :type => :view do
  before(:each) do
    assign(:product_review, ProductReview.new())
  end

  it "renders new product_review form" do
    render

    assert_select "form[action=?][method=?]", product_reviews_path, "post" do
    end
  end
end
