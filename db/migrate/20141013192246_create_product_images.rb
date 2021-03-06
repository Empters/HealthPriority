class CreateProductImages < ActiveRecord::Migration
  def change
    create_table :product_images do |t|
      t.integer :product_id, :null => false
      t.attachment :image
      t.integer :sort_order, :default => 0

      t.timestamps
    end
  end
end
