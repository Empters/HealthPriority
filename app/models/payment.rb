class Payment < ActiveRecord::Base
  has_many :items

  def paypal_url(return_path)
    values = {
        business: "health_prioritu_business@test.com",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}/payment/#{return_path}",
        invoice: id,
        amount: total,
        quantity: '1',
        notify_url: "#{Rails.application.secrets.app_host}/shopping_carts/hook"
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end
end
