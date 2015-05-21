class Order < ActiveRecord::Base

  before_save :before_save
  after_save :handle_status_changed

  # Validate required attributes
  validates_presence_of :gender_id, :first_name, :last_name, :email, :phone, :country_id, :city, :postal_code, :address, :payment_method
  validates_associated :order_products

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
        item_name: order_products_names,
        item_number: total_quantity,
        amount: total,
        quantity: total_quantity,
        notify_url: "#{Rails.application.secrets.app_host}/orders/hook",
        return: "#{Rails.application.secrets.app_host}/show#{return_path}",
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end

  private

  def before_save
    @was_a_new_record = new_record?
    return true
  end

  # Save order history when order status changed
  def handle_status_changed
    if @was_a_new_record || self.order_status_id_changed?
      @orderHistory = OrderHistory.new()
      @orderHistory.order = self
      @orderHistory.order_status = self.order_status
      @orderHistory.save!
    end
  end

  def order_products_names
    order_products.map { |f| f.name }.join(',')
  end

  def total_quantity
    order_products.empty? ? 0 : order_products.sum(:quantity)
  end

end
