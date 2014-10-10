class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :model
      t.integer :quantity
      t.integer :viewed
      t.string :image
      t.decimal :price
      t.integer :points
      t.text :description

      t.timestamps
    end
  end
end
