class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, :null => false
      t.string :model
      t.integer :quantity, :null => false, :default => 0
      t.integer :viewed
      t.string :image
      t.decimal :price, :null => false, :default => 0
      t.integer :points
      t.text :description
      t.integer :status, :null => false
      t.integer :manufacturer_id, :null => false
      t.integer :sort_order, :null => false, :default => 0
      t.date :date_available
      t.string :meta_keyword
      t.string :meta_description
      t.datetime :date_added, :null => false
      t.datetime :date_modified

      t.timestamps
    end
  end
end
