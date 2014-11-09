class DeliveryController < ApplicationController
  def index
    web_store_detail = WebStoreDetail.first
    @delivery = web_store_detail.nil? ? '' : web_store_detail.delivery.nil? ? '' : web_store_detail.delivery.html_safe
  end
end
