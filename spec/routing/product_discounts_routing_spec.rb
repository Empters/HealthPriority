require "rails_helper"

RSpec.describe ProductDiscountsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/product_discounts").to route_to("product_discounts#index")
    end

    it "routes to #new" do
      expect(:get => "/product_discounts/new").to route_to("product_discounts#new")
    end

    it "routes to #show" do
      expect(:get => "/product_discounts/1").to route_to("product_discounts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/product_discounts/1/edit").to route_to("product_discounts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/product_discounts").to route_to("product_discounts#create")
    end

    it "routes to #update" do
      expect(:put => "/product_discounts/1").to route_to("product_discounts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/product_discounts/1").to route_to("product_discounts#destroy", :id => "1")
    end

  end
end
