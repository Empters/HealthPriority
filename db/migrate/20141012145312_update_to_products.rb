class UpdateToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :status, :integer, :null => false
    add_column :products, :stock_status_id, :integer, :null => false
    add_column :products, :manufacture_id, :integer, :null => false
    add_column :products, :sort_order, :integer, :null => false, :default => 0
    add_column :products, :date_available, :date

    rename_column :products, :created_at, :date_added
    rename_column :products, :updated_at, :date_modified
  end

  def self.down
    remove_column :products, :status
    remove_column :products, :stock_status_id
    remove_column :products, :manufacture_id
    remove_column :products, :sort_order
    remove_column :products, :date_available

    rename_column :products, :date_added, :created_at
    rename_column :products, :date_modified, :updated_at
  end
end
