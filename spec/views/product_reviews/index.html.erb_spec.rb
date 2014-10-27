require 'rails_helper'

RSpec.describe "product_reviews/index", :type => :view do
  before(:each) do
    assign(:product_reviews, [
      ProductReview.create!(),
      ProductReview.create!()
    ])
  end

  it "renders a list of product_reviews" do
    render
  end
end
