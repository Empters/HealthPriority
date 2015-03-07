class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|

      # User data
      t.integer :user_id
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.integer :gender_id, :null => false
      t.integer :country_id, :null => false
      t.integer :state_id
      t.string :address, :null => false
      t.string :second_address
      t.string :city
      t.string :postal_code
      t.string :email, :null => false
      t.string :phone, :null => false
      t.string :fax

      # Order data
      t.string :total
      t.integer :total_quantity
      t.string :item_name
      t.string :item_number
      t.string :description

      # Payment data
      t.string :payment_method, :null => false
      t.string :status, default: 'new', :null => false
      t.string :currency, default: '£', :null => false
      t.string :transaction_id
      t.datetime :purchased_at

      t.timestamps
    end
  end
end
