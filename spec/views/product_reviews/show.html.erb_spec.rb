require 'rails_helper'

RSpec.describe "product_reviews/show", :type => :view do
  before(:each) do
    @product_review = assign(:product_review, ProductReview.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
