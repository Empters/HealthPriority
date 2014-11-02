class ContactsController < ApplicationController
  def index
    web_store_detail = WebStoreDetail.first
    @contacts = web_store_detail.nil? ? '' : web_store_detail.contact.nil? ? '' : web_store_detail.contact.html_safe
  end
end
