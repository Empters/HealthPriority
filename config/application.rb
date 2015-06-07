require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HealthPriority
  class Application < Rails::Application

    config.encoding = 'utf-8'

    config.assets.initialize_on_precompile = false

    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)

    # Help configuration for paperclip images
    config.paperclip_styles = {:thumb => '48x48'}
    config.paperclip_allow_image_content = ['image/jpeg', 'image/jpg', 'image/gif', 'image/png', 'image/pjpeg', 'image/x-png']
    config.paperclip_allow_image_content_message = 'invalid image format!'

    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    config.assets.paths << "#{Rails}/vendor/assets/fonts"
  end
end
