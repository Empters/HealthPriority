class Payment < ActiveRecord::Base

  # Validate required attributes
  validates_presence_of :gender_id, :first_name, :last_name, :email, :phone, :country_id, :city, :postal_code, :address, :payment_method

  has_many :items, autosave: true
  has_one :order, autosave: true

  belongs_to :user
  belongs_to :gender
  belongs_to :country
  belongs_to :state

  def paypal_url(return_path)
    values = {
        business: 'new_test_acc@abv.bg',
        cmd: '_xclick',
        upload: 1,
        invoice: id,
        currency_code: 'GBP',
        item_name: item_name,
        item_number: item_number,
        amount: amount,
        quantity: quantity,
        notify_url: "#{Rails.application.secrets.app_host}/payments/hook",
        return: "#{Rails.application.secrets.app_host}/show/#{return_path}",
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end

end
