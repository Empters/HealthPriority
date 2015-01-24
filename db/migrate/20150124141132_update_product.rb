class UpdateProduct < ActiveRecord::Migration
  def up
    add_column :products, :questions_answers, :text, default: nil
  end

  def down
    remove_column :products, :questions_answers
  end
end
