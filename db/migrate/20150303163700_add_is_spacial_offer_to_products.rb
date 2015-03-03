class AddIsSpacialOfferToProducts < ActiveRecord::Migration
  def change
    add_column :products, :is_spacial_offer, :boolean, default: false
  end
end
