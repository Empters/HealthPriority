require "rails_helper"

RSpec.describe ProductReviewsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/product_reviews").to route_to("product_reviews#index")
    end

    it "routes to #new" do
      expect(:get => "/product_reviews/new").to route_to("product_reviews#new")
    end

    it "routes to #show" do
      expect(:get => "/product_reviews/1").to route_to("product_reviews#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/product_reviews/1/edit").to route_to("product_reviews#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/product_reviews").to route_to("product_reviews#create")
    end

    it "routes to #update" do
      expect(:put => "/product_reviews/1").to route_to("product_reviews#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/product_reviews/1").to route_to("product_reviews#destroy", :id => "1")
    end

  end
end
