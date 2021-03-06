ActiveAdmin.register_page 'Import Products' do

  # Set item menu position
  menu :parent => 'System', :priority => 3

  # Left slider with help import data
  sidebar 'Allow columns' do
    ul do
      li 'Name'
      li 'Full Name'
      li 'Benefits'
      li 'Description'
      li 'Ingredients'
      li 'Direction'
      li 'Category'
      li 'Subcategory'
      li 'Price'
      li 'Quantity'
      li 'Questions & Answers'
      li 'Manufacturer'
      li 'Stock status'
      li 'Best Seller'
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
    product_file = params[:productFile]
    images_file = params[:imagesFile]

    # Import products from excel to DB
    import_products(product_file)

    # Import products images from zip to DB
    import_product_images(images_file)

    # Redirect to import page with notice
    redirect_to admin_import_products_path, :notice => 'Import products is success!'
  end

  controller do

    # Require gems
    require 'roo'

    # Read products from excel and add its to DB
    def import_products(product_file)

      # Check if has file
      if product_file.nil?
        return
      end

      # Open workbook
      workbook = open_spreadsheet(product_file)

      headers = Hash.new
      workbook.row(1).each_with_index { |header, i|
        headers[header.downcase] = i
      }

      # Import products is in one transaction
      ActiveRecord::Base.transaction do

        ((workbook.first_row + 1)..workbook.last_row).each do |i|

          manufacturer_header_name = headers['bg manufacturer'].blank? ? headers['manufacturer'] : headers['bg manufacturer']
          if workbook.row(i)[manufacturer_header_name].nil?
            next
          end

          # Init manufacturer
          manufacturer_name = workbook.row(i)[manufacturer_header_name].strip
          manufacturer = Manufacturer.where('lower(name) = ?', manufacturer_name.downcase).first
          if manufacturer.nil?
            manufacturer = Manufacturer.create!(name: manufacturer_name)
          end

          # Init category
          category_header_name = headers['bg category'].blank? ? headers['category'] : headers['bg category']
          category_name = workbook.row(i)[category_header_name].strip
          category = Category.where('lower(name) = ?', category_name.downcase).first
          if category.nil?
            category = Category.create!(name: category_name)
          end

          # Init subcategory
          subcategory_header_name = headers['bg subcategory'].blank? ? headers['subcategory'] : headers['bg subcategory']
          subcategory_name = workbook.row(i)[subcategory_header_name]
          unless subcategory_name.blank?
            subcategory_name = subcategory_name.strip
            subcategory = Category.where('lower(name) = ?', subcategory_name.downcase).first
            if subcategory.nil?
              subcategory = Category.create!(name: subcategory_name, parent_id: category.id)
            end
          end

          # Init manufacturer
          stock_status_header_name = headers['bg stock status'].blank? ? headers['stock status'] : headers['bg stock status']
          stock_status_name = workbook.row(i)[stock_status_header_name]
          unless stock_status_name.nil? || stock_status_name.blank?
            stock_status_name = stock_status_name.strip
            stock_status = StockStatus.where('lower(name) = ?', stock_status_name.downcase).first
            if stock_status.nil?
              stock_status = StockStatus.create!(name: stock_status_name)
            end
          end

          # Create or update product
          name = workbook.row(i)[headers['name']].strip
          product = Product.find_or_create_by(name: name)
          product.update_attributes!(
              name: workbook.row(i)[headers['bg name'].blank? ? headers['name'] : headers['bg name']].strip,
              full_name: workbook.row(i)[headers['bg full name'].blank? ? headers['full name'] : headers['bg full name']].strip,
              benefits: workbook.row(i)[headers['bg benefits'].blank? ? headers['benefits'] : headers['bg benefits']],
              description: workbook.row(i)[headers['bg description'].blank? ? headers['description'] : headers['bg description']],
              ingredients: workbook.row(i)[headers['bg ingredients'].blank? ? headers['ingredients'] : headers['bg ingredients']],
              direction: workbook.row(i)[headers['bg direction'].blank? ? headers['direction'] : headers['bg direction']],
              stock_status_id: stock_status.id,
              price: workbook.row(i)[headers['bg price'].blank? ? headers['price'] : headers['bg price']].to_f,
              quantity: workbook.row(i)[headers['bg quantity'].blank? ? headers['quantity'] : headers['bg quantity']].to_i,
              is_best_seller: !workbook.row(i)[headers['best seller']].blank? && workbook.row(i)[headers['best seller']].downcase == 'true',
              questions_answers: workbook.row(i)[headers['bg questions & answers'].blank? ? headers['questions & answers'] : headers['bg questions & answers']],
              manufacturer_id: manufacturer.id,
              categories: subcategory.nil? ? [category] : [subcategory])
        end

      end
    end

    # Open excel file
    def open_spreadsheet(file)

      puts "Open file #{file.original_filename}"

      case File.extname(file.original_filename)
        when '.xls' then
          Roo::Excel.new(file.path, nil, :ignore)
        when '.xlsx' then
          Roo::Excelx.new(file.path, nil, :ignore)
        else
          raise "Unknown file type: #{file.original_filename}"
      end
    end

    def import_product_images(image_file)

      # Check if has file
      if image_file.nil?
        return
      end

      # Validate zip file extension
      if File.extname(image_file.original_filename) != '.zip'
        raise 'Product image import file must be zip file!'
      end

      # Open zip file
      zip_file = Zip::File.open(image_file.path)

      # Read zip directories
      directories = Array.new
      zip_file.each do |entry|

        entry.name = entry.name.force_encoding('UTF-8')
        unless entry.name.valid_encoding?
          entry.name = entry.name.encode('UTF-8', :invalid => :replace, :undef => :replace, :replace => '?')
          puts "Zip has directory in invalid encoding: #{entry.name}"
          next
        end

        puts "Read zip entry: #{entry.name}"
        directory_name = File.dirname(entry.name)
        unless directory_name == '.' || directories.include?(directory_name)
          directories << directory_name
        end
      end

      # Import products is in one transaction
      ActiveRecord::Base.transaction do
        directories.each do |directory|
          begin
            # Search product by name
            puts "Working with zip directory: #{directory}"
            product = Product.where('lower(name) = ?', directory.downcase).first
            unless product.nil?
              images = Array.new
              glob_args = File.join("#{directory}", '*.*')
              entry_images = zip_file.glob(glob_args)
              entry_images.select { |n| n.name.downcase.match('^.*\.(jpg|jpeg|png|gif)$') }.each do |entry_image|
                puts entry_image.name
                if entry_image.name.downcase.match('^.*main\.(jpg|jpeg|png|gif)$')
                  product.image = get_image(entry_image)
                else
                  otherImage = ProductImage.create!(
                      product: product,
                      image: get_image(entry_image)
                  )

                  images << otherImage
                end
              end

              unless images.empty?
                product.product_images = images
              end

              product.save!
            end
          rescue => ex
            logger.error ex.message
            next
          end
        end
      end
    end

    def get_image(zip_entry)

      main_image = Tempfile.new([File.basename(zip_entry.name), File.extname(zip_entry.name)])
      main_image.binmode
      main_image.write zip_entry.get_input_stream.read

      return main_image
    end

  end

end