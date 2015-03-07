class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, :null => false
      t.string :full_name
      t.decimal :price, :null => false, :default => 0
      t.integer :quantity, :null => false, :default => 0
      t.integer :manufacturer_id, :null => false
      t.integer :stock_status_id, :null => false, :default => 1
      t.text :ingredients
      t.text :benefits
      t.text :description
      t.text :direction
      t.text :questions_answers, default: nil
      t.attachment :image
      t.integer :viewed
      t.integer :points
      t.boolean :active, :null => false, :default => true
      t.integer :sort_order, :null => false, :default => 0
      t.date :date_available
      t.string :meta_keyword
      t.string :meta_description
      t.boolean :is_best_seller, default: false
      t.boolean :is_spacial_offer, default: false

      t.timestamps
    end
  end
end
