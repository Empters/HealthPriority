class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.column :iso, :string, :size => 2
      t.column :name, :string, :size => 80
    end
  end
end
