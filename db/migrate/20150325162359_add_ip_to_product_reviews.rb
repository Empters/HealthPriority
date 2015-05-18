class AddIpToProductReviews < ActiveRecord::Migration
  def change
    add_column :product_reviews, :ip, :string
  end
end
