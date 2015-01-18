class CreateProductRelated < ActiveRecord::Migration
  def change
    create_table :product_related, id: false  do |t|
      t.references :product, :null => false
      t.integer :related_id, :null => false
    end
  end
end
