ActiveAdmin.register_page 'Import Products' do

  # Set item menu position
  menu :parent => 'System', :priority => 3

  content do
    form :url => '/admin/import_products/import', :method => :post do |f|
      f.input :name => 'authenticity_token', :type => :hidden, :value => form_authenticity_token.to_s
      f.input :name => 'importFile', :type => :file
      f.input :type => :submit
    end
  end

  page_action :import, :method => :post do
    # Try to import products
    file = params[:importFile]

    redirect_to '/admin/import_products', :notice => 'Import products is success!'
  end

end