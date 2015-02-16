class Payment < ActiveRecord::Base

  # Validate required attributes
  validates_presence_of :name, :address, :city, :company, :country, :email, :item_name, :item_number, :items, :phone, :postal_code, :state, :status, :total, :total_quantity, :payment_method

  has_many :items, autosave: true
  belongs_to :user

  def paypal_url(return_path)
    values = {
        business: 'new_test_acc@abv.bg',
        cmd: '_xclick',
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: id,
        amount: total,
        quantity: total_quantity,
        notify_url: "#{Rails.application.secrets.app_host}/payments/hook",
        item_name: item_name,
        item_number: item_number
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end

end
