class AboutUsController < ApplicationController
  add_breadcrumb 'Home', :root_path

  def index
    add_breadcrumb 'About', :about_us_path

    web_store_detail = WebStoreDetail.first
    @about_us = web_store_detail.nil? ? '' : web_store_detail.about_us.nil? ? '' : web_store_detail.about_us.html_safe
  end
end
