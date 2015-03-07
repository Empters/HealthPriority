class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.column :name, :string, :size => 80
      t.column :country_id, :integer
      t.column :iso, :string, :size=>2
    end
  end
end
