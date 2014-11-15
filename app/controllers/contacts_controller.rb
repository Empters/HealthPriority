class ContactsController < ApplicationController
  add_breadcrumb 'Home', :root_path

  def index
    add_breadcrumb 'Contacts', :contacts_path

    web_store_detail = WebStoreDetail.first
    @contacts = web_store_detail.nil? ? '' : web_store_detail.contact.nil? ? '' : web_store_detail.contact.html_safe
  end
end
