class CreateManufacturers < ActiveRecord::Migration
  def change
    create_table :manufacturers do |t|
      t.string :name, :null => false
      t.attachment :image
      t.text :description
      t.integer :sort_order, :default => 0

      t.timestamps
    end
  end
end
