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

    # Get import directory
    importDirectory = Rails.root.join('tmp/imports')

    # Create import directory if not exist
    FileUtils.mkdir_p(importDirectory) unless File.directory?(importDirectory)

    # Clear import directory - delete files and folders
    # FileUtils.rm_rf(importDirectory + '/*')

    # Try to save file local
    excel_file = Rails.root.join(importDirectory, product_file_io.original_filename)
    File.open(excel_file, 'wb') do |file|
      file.write(product_file_io.read)
    end

    # Import products from excel to DB
    import_products(excel_file)

    # Redirect to import page with notice
    redirect_to admin_import_products_path, :notice => 'Import products is success!'
  end

  controller do

    # Require gems
    require 'spreadsheet'

    # Read products from excel and add its to DB
    def import_products(excel_path)
      book = Spreadsheet.open excel_path
      sheet = book.worksheet 0

=begin
    header_row = sheet.row(0)
    header_row.each do |cell|
      cell
    end
=end

      # Read excel file
      sheet.each 1 do |row|

        # Init manufacturer
        manufacturer_name = row[13]
        manufacturer = Manufacturer.where('lower(name) = ?', manufacturer_name.downcase).first
        if manufacturer.nil?
          manufacturer = Manufacturer.create(name: manufacturer_name)
        end

        # Init category
        category_name = row[6]
        category = Category.where('lower(name) = ?', category_name.downcase).first
        if category.nil?
          category = Category.create(name: manufacturer_name)
        end

        # Init subcategory
        subcategory_name = row[7]
        if subcategory_name?
          subcategory = Category.where('lower(name) = ?', subcategory_name.downcase).first
          if subcategory.nil?
            subcategory = Category.create(name: manufacturer_name, parent_id: category.id)
          end
        end

        # Create product
        Product.create(name: row[0], full_name: row[1], benefits: row[3], description: row[4], ingredients: row[5], direction: row[6], price: row[8], quantity: row[9], manufacturer_id: manufacturer.id, categories: subcategory.nil? ? [category] : [subcategory])

      end
  end

  end

end