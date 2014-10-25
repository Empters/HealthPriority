class CreateProductsCategories < ActiveRecord::Migration
  def change
    create_table :products_categories do |t|
      t.references :product
      t.references :category
    end
  end
end
