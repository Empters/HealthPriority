class ContactsController < ApplicationController
  def index
    @contacts = WebStoreDetail.first.nil? ? 'No contacts data' : WebStoreDetail.first.contact.html_safe
  end
end
