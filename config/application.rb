# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Reto
  ##
  # Initial settings
  #
  class Application < Rails::Application
    EXCEPTION_RECIPIENTS = 'me@ferpadron.com,fernandopadrontorres@gmail.com'

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.default charset: 'utf-8'

    config.action_mailer.smtp_settings = {
      address: Rails.application.credentials.dig(:smtp, :address),
      port: 587,
      domain: Rails.application.credentials.dig(:smtp, :domain),
      authentication: 'plain',
      enable_starttls_auto: true,
      user_name: Rails.application.credentials.dig(:smtp, :user_name),
      password: Rails.application.credentials.dig(:smtp, :password),
      openssl_verify_mode: 'none'
    }

    config.exception_handler = {
      dev: true,
      db: false,
      email: EXCEPTION_RECIPIENTS,

      exceptions: {
        all: { layout: nil, notification: true }
      }
    }
  end
end
# exception_handler needs access to his view in gem code (assets -> precompile array) but APIs has no views
Rails.configuration.assets = JSON.parse({ precompile: [] }.to_json, object_class: OpenStruct)
require 'exception_handler'
