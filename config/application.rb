require File.expand_path('../boot', __FILE__)

# require 'rails/all'
# require "active_record/railtie"
require "active_model/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module IG9gag
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.cache_store = :redis_store, (ENV['REDISCLOUD_URL']  || 'redis://localhost:6379/0/cache')
    config.autoload_paths += Dir["#{config.root}/app/lib", "#{config.root}/app/lib/**/"]
    config.assets.paths << Rails.root.join("vendor","assets","bower_components")
    config.assets.paths << Rails.root.join("vendor","assets","bower_components","videogular-themes-default","fonts")
    config.assets.paths << Rails.root.join("vendor","assets","fonts")
    config.angular_templates.inside_paths = ['app/assets']
    config.assets.precompile << %r(.*.(?:eot|svg|ttf|woff)$)
  end
end
