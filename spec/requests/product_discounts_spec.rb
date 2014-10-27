require 'rails_helper'

RSpec.describe "ProductDiscounts", :type => :request do
  describe "GET /product_discounts" do
    it "works! (now write some real specs)" do
      get product_discounts_path
      expect(response.status).to be(200)
    end
  end
end
