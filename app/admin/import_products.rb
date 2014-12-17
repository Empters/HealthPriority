ActiveAdmin.register_page 'Import Products' do

  # Set item menu position
  menu :parent => 'System', :priority => 3

  # Left slider with help import data
  sidebar :help do
    ul do
      li 'First Line of Help'
    end
  end

  # Index page content
  content do
    form :action => admin_import_products_import_path, :enctype => 'multipart/form-data', :method => :post do |f|
      f.fieldset :class => 'inputs' do
        f.input :name => 'authenticity_token', :type => :hidden, :value => form_authenticity_token.to_s
        f.legend do
          f.span 'Import products'
        end
        f.ol do
          f.li do
            f.label 'Excel file with product data'
            f.input :name => 'productFile', :type => :file, :required => false
          end
          f.li do
            f.label 'Zip file with product images'
            f.input :name => 'imagesFile', :type => :file, :required => false
          end
        end
      end
      f.fieldset :class => 'actions' do
        f.input :type => :submit, :value => 'Import'
      end
    end
  end

  # Import file action
  page_action :import, :method => :post do

    # Try to import products
    product_file_io = params[:productFile]
    images_file_io = params[:imagesFile]

    # Import products from excel to DB
    import_products(product_file_io)

    # Redirect to import page with notice
    redirect_to admin_import_products_path, :notice => 'Import products is success!'
  end

  controller do

    # Require gems
    require 'roo'

    # Read products from excel and add its to DB
    def import_products(file)

      # Open workbook
      workbook = open_spreadsheet(file)

      headers = Hash.new
      workbook.row(1).each_with_index { |header, i|
        headers[header.downcase] = i
      }

      # Import products is in one transaction
      ActiveRecord::Base.transaction do

        ((workbook.first_row + 1)..workbook.last_row).each do |i|

          product_name = workbook.row(i)[headers['name']]

          # Init manufacturer
          manufacturer_name = workbook.row(i)[headers['manufacturer']]
          manufacturer = Manufacturer.where('lower(name) = ?', manufacturer_name.downcase).first
          if manufacturer.nil?
            manufacturer = Manufacturer.create!(name: manufacturer_name)
          end

          # Init category
          category_name = workbook.row(i)[headers['category']]
          category = Category.where('lower(name) = ?', category_name.downcase).first
          if category.nil?
            category = Category.create!(name: category_name)
          end

          # Init subcategory
          subcategory_name = workbook.row(i)[headers['subcategory']]
          if !subcategory_name.blank?
            subcategory = Category.where('lower(name) = ?', subcategory_name.downcase).first
            if subcategory.nil?
              subcategory = Category.create!(name: subcategory_name, parent_id: category.id)
            end
          end

          # Init manufacturer
          stock_status_name = workbook.row(i)[headers['stock status']]
          if !stock_status_name.nil? && !stock_status_name.blank?
            stock_status = StockStatus.where('lower(name) = ?', stock_status_name.downcase).first
            if stock_status.nil?
              stock_status = StockStatus.create!(name: stock_status_name)
            end
          end

          # Create product
          product = Product.create!(
              name: workbook.row(i)[headers['name']],
              full_name: workbook.row(i)[headers['full name']],
              benefits: workbook.row(i)[headers['benefits']],
              description: workbook.row(i)[headers['description']],
              ingredients: workbook.row(i)[headers['ingredients']],
              direction: workbook.row(i)[headers['direction']],
              stock_status_id: stock_status.id,
              price: workbook.row(i)[headers['price']].to_f,
              quantity: workbook.row(i)[headers['quantity']].to_i,
              manufacturer_id: manufacturer.id,
              categories: subcategory.nil? ? [category] : [subcategory])
        end
      end
    end

    def open_spreadsheet(file)
      case File.extname(file.original_filename)
        when '.xls' then
          Roo::Excel.new(file.path, nil, :ignore)
        when '.xlsx' then
          Roo::Excelx.new(file.path, nil, :ignore)
        else
          raise "Unknown file type: #{file.original_filename}"
      end
    end

  end

end