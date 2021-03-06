ActiveAdmin.register AdminUser do

  # Set item menu position
  menu :parent => 'System', :priority => 2

  # Set permit parameters
  permit_params :email, :password, :password_confirmation

  index do
    puts "--------    admin index do   ----------"
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    puts "------------   admin form do   -------------"
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
