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
    fileName = Rails.root.join(importDirectory, product_file_io.original_filename)
    File.open(fileName, 'wb') do |file|
      file.write(uploaded_io.read)
    end

    #TODO - import products

    # Redirect to import page with notice
    redirect_to admin_import_products_path, :notice => 'Import products is success!'
  end

end