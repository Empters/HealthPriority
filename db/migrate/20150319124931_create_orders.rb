class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :mc_gross
      t.integer :invoice
      t.string :protection_eligibility
      t.string :address_status
      t.string :payer_id
      t.decimal :tax
      t.string :address_street
      t.date :payment_date
      t.string :payment_status
      t.string :charset
      t.string :address_zip
      t.string :first_name
      t.string :address_country_code
      t.string :address_name
      t.string :notify_version
      t.string :custom
      t.string :payer_status
      t.string :business
      t.string :address_country
      t.string :address_city
      t.integer :quantity
      t.string :verify_sign
      t.string :payer_email
      t.string :txn_id
      t.string :payment_type
      t.string :last_name
      t.string :address_state
      t.string :receiver_email
      t.string :receiver_id
      t.string :pending_reason
      t.string :txn_type
      t.string :item_name
      t.string :mc_currency
      t.integer :item_number
      t.string :residence_country
      t.integer :test_ipn
      t.decimal :handling_amount
      t.string :transaction_subject
      t.string :payment_gross
      t.decimal :shipping
      t.string :ipn_track_id

      t.timestamps
    end
  end
end
