class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, :null => false
      t.text :description
      t.string :image
      t.integer :status, :null => false
      t.integer :sort_order, :default => 0
      t.string :meta_keyword
      t.string :meta_description

      t.timestamps
    end
  end
end
