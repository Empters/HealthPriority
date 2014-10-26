require 'rails_helper'

RSpec.describe "Manufacturers", :type => :request do
  describe "GET /manufacturers" do
    it "works! (now write some real specs)" do
      get manufacturers_path
      expect(response.status).to be(200)
    end
  end
end
