ActiveAdmin.register WebStoreDetail do

  # Set item menu position
  menu :parent => 'System', :priority => 1

  # Set permit parameters
  permit_params :contact, :delivery, :faq

  # Init edit page
  form :html => {:multipart => true} do |f|
    f.inputs 'Manufacturer' do
      f.input :faq, :as => :ckeditor
      f.input :delivery, :as => :ckeditor
      f.input :contact, :as => :ckeditor
    end
    f.actions
  end
end
