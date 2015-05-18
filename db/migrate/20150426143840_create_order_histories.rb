class CreateOrderHistories < ActiveRecord::Migration
  def change
    create_table :order_histories do |t|
      t.integer :order_id
      t.integer :order_status_id
      t.text :comment
      t.timestamps
    end
  end
end
