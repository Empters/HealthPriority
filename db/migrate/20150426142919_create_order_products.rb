class CreateOrderProducts < ActiveRecord::Migration
  def change
    create_table :order_products do |t|
      t.integer :order_id
      t.integer :product_id
      t.string :name
      t.integer :quantity
      t.decimal :price
      t.decimal :total
      t.timestamps
    end
  end
end
