class AboutUsController < ApplicationController
  def index
    web_store_detail = WebStoreDetail.first
    @about_us = web_store_detail.nil? ? '' : web_store_detail.about_us.nil? ? '' : web_store_detail.about_us.html_safe
  end
end
