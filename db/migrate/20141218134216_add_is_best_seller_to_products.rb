class AddIsBestSellerToProducts < ActiveRecord::Migration
  def change
    add_column :products, :is_best_seller, :boolean, default: false
  end
end
