class CreateProductsCategories < ActiveRecord::Migration
  def change
    create_table :products_categories do |t|
      t.integer :product_id
      t.integer :category_id
    end
  end
end
