class CreateProductReviews < ActiveRecord::Migration
  def change
    create_table :product_reviews do |t|
      t.integer :product_id, :null => false
      t.integer :customer_id
      t.string :author
      t.string :text, :null => false
      t.integer :rating
      t.integer :status, :null => false
      t.timestamps
    end
  end
end
