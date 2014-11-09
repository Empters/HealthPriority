class FaqController < ApplicationController
  def index
    web_store_detail = WebStoreDetail.first
    @faq = web_store_detail.nil? ? '' : web_store_detail.faq.nil? ? '' : web_store_detail.faq.html_safe
  end
end
