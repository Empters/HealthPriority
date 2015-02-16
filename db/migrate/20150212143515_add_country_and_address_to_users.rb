class AddCountryAndAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :country, :string
    add_column :users, :address, :string
  end
end
