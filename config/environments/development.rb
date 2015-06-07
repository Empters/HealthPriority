Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Gmail SMTP server setup
  ActionMailer::Base.smtp_settings = {
      :address => 'smtp.gmail.com',
      :enable_starttls_auto => false,
      :port => 465,
      :authentication => :plain,
      :user_name => 'healthpriorityltd@gmail.com',
      :password => 'healthpriorityltd2014',
      :ssl => true
  }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true


  # Ensure you have defined default url options in your environments files. Here
  # is an example of default_url_options appropriate for a development environment
  # in config/environments/development.rb:
  # In production, :host should be set to the actual host of your application.
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  # .... need to check this?!

  # Set ImageMagick path - crop image
  Paperclip.options[:command_path] = 'C:/Program Files/ImageMagick-6.8.9-Q16'
  # Paperclip.options[:command_path] = 'C:\Program Files\ImageMagick-6.9.0-Q16'

  # repair paperclip validate content type error
  require 'paperclip/media_type_spoof_detector'
  Paperclip::MediaTypeSpoofDetector.class_eval do
    def spoofed?
      false
    end
    def type_from_file_command
      begin
        Paperclip.run('file', '-b --mime :file', :file => @file.path)
      rescue Cocaine::CommandLineError
        ''
      end
    end
  end

  #config.allow_concurrency = true

  # Setting default language
  config.i18n.enforce_available_locales = true
  # config.i18n.default_locale = :'en-GB'
  config.i18n.default_locale = :bg
end
