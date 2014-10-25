class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :parent_id
      t.string :name, :null => false
      t.text :description
      t.attachment :image
      t.boolean :active, :null => false, :default => true
      t.integer :sort_order, :default => 0
      t.string :meta_keyword
      t.string :meta_description

      t.timestamps
    end
  end
end
