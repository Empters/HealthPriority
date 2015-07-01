class AddWebStoreDetails < ActiveRecord::Migration
  def change
    add_column :web_store_details, :rights_and_obligations, :text
    add_column :web_store_details, :license, :text
  end
end
