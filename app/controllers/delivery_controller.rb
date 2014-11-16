class DeliveryController < ApplicationController
  add_breadcrumb 'Home', :root_path

  def index
    add_breadcrumb 'Delivery', :delivery_path

    web_store_detail = WebStoreDetail.first
    @delivery = web_store_detail.nil? ? '' : web_store_detail.delivery.nil? ? '' : web_store_detail.delivery.html_safe
  end
end
