class CreateProductDiscounts < ActiveRecord::Migration
  def change
    create_table :product_discounts do |t|
      t.integer :product_id, :null => false
      t.integer :customer_group_id
      t.integer :quantity, :null => false
      t.integer :priority
      t.decimal :price, :null => false
      t.date :date_start
      t.date :date_end

      t.timestamps
    end
  end
end
