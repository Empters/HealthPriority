class CreateWebStoreDetails < ActiveRecord::Migration
  def change
    create_table :web_store_details do |t|
      t.text :contact
      t.text :delivery
      t.text :faq
      t.text :about_us
      t.text :partners
      t.text :payment_methods

      t.timestamps
    end
  end
end
