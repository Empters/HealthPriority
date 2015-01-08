class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :payment_id
      t.integer :product_id
      t.string :name
      t.string :price
      t.string :quantity

      t.timestamps
    end
  end
end
