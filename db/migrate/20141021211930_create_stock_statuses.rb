class CreateStockStatuses < ActiveRecord::Migration
  def change
    create_table :stock_statuses do |t|
      t.string :name, :null => false
      t.timestamps
    end
  end
end
