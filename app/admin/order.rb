ActiveAdmin.register Order do

  # Set item menu position
  menu :parent => 'Sales', :priority => 1

  # Set permit parameters
  permit_params :order_status_id

  # Except create new order
  actions :all, except: [:new]

  # Init filters
  filter :id
  filter :order_status_id, :as => :select, collection: OrderStatus.all, :member_label => :name, :member_value => :id
  filter :user_id, :as => :select, collection: User.all, :member_label => :full_name, :member_value => :id
  filter :payment_method
  filter :payment_status
  filter :payment_date
  filter :payment_transaction_id
  filter :payer_id
  filter :payer_first_name
  filter :payer_last_name
  filter :payer_country
  filter :payer_state
  filter :payer_address
  filter :payer_second_address
  filter :payer_city
  filter :payer_postal_code
  filter :payer_email
  filter :payer_phone
  filter :payer_fax
  filter :created_at
  filter :updated_at

  # Init index page
  index do
    selectable_column
    column :id
    actions
  end

  # Init edit page
  form do |f|
    panel 'Order data' do
      'Order data...'
    end
    panel 'Payment data' do
      'Payment data...'
    end
    panel 'Payer data' do
      'Payer data...'
    end
    inputs 'Order Status', :order_status_id, :as => :select, collection: OrderStatus.all, :member_label => :name, :member_value => :id, :include_blank => 'Choose order status'
    f.actions
  end

end
