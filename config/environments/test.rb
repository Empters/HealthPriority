Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure static asset server for tests with Cache-Control for performance.
  config.serve_static_assets  = true
  config.static_cache_control = 'public, max-age=3600'

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # This should be changed later to use mail server, not google
  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  # Gmail SMTP server setup
  ActionMailer::Base.smtp_settings = {
      :address => "smtp.gmail.com",
      :enable_starttls_auto => false,
      :port => 465,
      :authentication => :plain,
      :user_name => "healthpriorityltd@gmail.com",
      :password => 'healthpriorityltd2014',
      :ssl => true
  }


  config.action_mailer.default_url_options = { host: 'health.empters.com' }

  # Set ImageMagick path - crop image
  # Paperclip.options[:command_path] = '/usr/local/bin/'
  Paperclip.options[:command_path] = '/usr/bin'

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

  #Setting default language
  config.i18n.enforce_available_locales = true
  config.i18n.default_locale = :en
end
