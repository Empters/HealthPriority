class UpdateWebStoreDetails < ActiveRecord::Migration

  def up
    add_column :web_store_details, :partners, :text, default: nil
    add_column :web_store_details, :payment_methods, :text, default: nil
  end

  def down
    remove_column :web_store_details, :partners
    remove_column :web_store_details, :payment_methods
  end

end
