class AddMcFeeToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :mc_fee, :decimal
  end
end
