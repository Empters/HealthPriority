class CreateProductsCategories < ActiveRecord::Migration
  def change
    create_table :products_categories, id: false do |t|
      t.references :product
      t.references :category
    end
  end
end
