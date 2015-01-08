class Payment < ActiveRecord::Base
  has_many :items, autosave: true
  belongs_to :user

  def paypal_url(return_path)
    values = {
        business: "health_prioritu_business@test.com",
        cmd: "_xclick",
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
