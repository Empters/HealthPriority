require 'rails_helper'

RSpec.describe "product_reviews/edit", :type => :view do
  before(:each) do
    @product_review = assign(:product_review, ProductReview.create!())
  end

  it "renders the edit product_review form" do
    render

    assert_select "form[action=?][method=?]", product_review_path(@product_review), "post" do
    end
  end
end
