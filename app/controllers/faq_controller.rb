class FaqController < ApplicationController
  add_breadcrumb 'Home', :root_path

  def index
    add_breadcrumb 'FAQ', :faq_path

    web_store_detail = WebStoreDetail.first
    @faq = web_store_detail.nil? ? '' : web_store_detail.faq.nil? ? '' : web_store_detail.faq.html_safe
  end
end
