class Order < ActiveRecord::Base

  after_save :handle_status_changed, :if => :status_changed?

  # Validate required attributes
  validates_presence_of :gender_id, :first_name, :last_name, :email, :phone, :country_id, :city, :postal_code, :address, :payment_method

  has_many :order_products, autosave: true
  has_many :order_histories

  belongs_to :user
  belongs_to :gender
  belongs_to :country
  belongs_to :state
  belongs_to :order_status

  def paypal_url(return_path)
    values = {
        business: 'test123445@abv.bg',
        cmd: '_xclick',
        upload: 1,
        invoice: id,
        currency_code: 'GBP',
        item_name: order_products.map { |f| f.name }.join(','),
        item_number: quantity,
        amount: price,
        quantity: quantity,
        notify_url: "#{Rails.application.secrets.app_host}/orders/hook",
        return: "#{Rails.application.secrets.app_host}/show#{return_path}",
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end

  private

  # Save order history when order status changed
  def handle_status_changed

    @orderHistory = OrderHistory.new()
    @orderHistory.order = self
    @orderHistory.order_status = self.order_status
    @orderHistory.save!

  end

end
