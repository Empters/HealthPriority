ActiveAdmin.register WebStoreDetail do

  # Set item menu position
  menu :parent => 'System', :priority => 1

  # Set permit parameters
  permit_params :about_us, :contact, :delivery, :faq, :partners, :payment_methods

  # Init filters
  filter :about_us
  filter :contact
  filter :faq
  filter :delivery
  filter :partners
  filter :payment_methods
  filter :created_at
  filter :updated_at

  # Init index page
  index do
    selectable_column
    column 'About us' do |post|
      div post.about_us.nil? ? '' : post.about_us.html_safe
    end
    column 'Contact' do |post|
      div post.contact.nil? ? '' : post.contact.html_safe
    end
    column 'FAQ' do |post|
        div post.faq.nil? ? '' : post.faq.html_safe
    end
    column 'Delivery' do |post|
      div post.delivery.nil? ? '' : post.delivery.html_safe
    end
    column 'Partners' do |post|
      div post.partners.nil? ? '' : post.partners.html_safe
    end
    column 'Payment methods' do |post|
      div post.payment_methods.nil? ? '' : post.payment_methods.html_safe
    end
    column :created_at
    column :updated_at
    actions
  end

  # Init edit page
  form :html => {:multipart => true} do |f|
    f.inputs do
      f.input :about_us, :as => :ckeditor
      f.input :contact, :as => :ckeditor
      f.input :faq, :as => :ckeditor
      f.input :delivery, :as => :ckeditor
      f.input :partners, :as => :ckeditor
      f.input :payment_methods, :as => :ckeditor
    end
    f.actions
  end
end
