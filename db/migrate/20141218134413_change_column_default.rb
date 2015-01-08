class ChangeColumnDefault < ActiveRecord::Migration
  def change
    change_column_default(:products, :is_best_seller, false)
  end
end
