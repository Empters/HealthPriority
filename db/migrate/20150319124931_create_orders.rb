class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|

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
      t.string :invoice
      t.integer :order_status_id, default: 1, :null => false
      t.decimal :total
      t.string :description
      t.string :currency, default: '£', :null => false
      t.string :ip

      # Payment data
      t.string :payment_method, :null => false
      t.string :payment_status
      t.date :payment_date
      t.integer :payment_transaction_id

      # Payer data
      t.string :payer_id
      t.string :payer_first_name
      t.string :payer_last_name
      t.string :payer_country
      t.string :payer_state
      t.string :payer_address
      t.string :payer_second_address
      t.string :payer_city
      t.string :payer_postal_code
      t.string :payer_email
      t.string :payer_phone
      t.string :payer_fax

      t.timestamps
    end

    add_index :orders, :invoice, unique: true
  end
end
