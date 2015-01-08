class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.string :payment_method
      t.string :name
      t.string :company
      t.string :phone
      t.string :email
      t.string :address
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country
      t.string :total
      t.string :currency, default: '£'
      t.string :description
      t.string :status, default: 'new'
      t.string :transaction_id
      t.integer :total_quantity
      t.datetime :purchased_at
      t.string :item_name
      t.string :item_number
      t.timestamps
    end
  end
end
