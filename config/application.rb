require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ilearn
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    $liensettings = config_for(:liensettings)
    config.load_defaults 5.1
    config.i18n.default_locale = "zh-TW"
    config.time_zone = "Taipei"
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end