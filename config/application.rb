require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.time_zone = ENV["TZ"]
    config.active_record.default_timezone = :utc
    config.i18n.default_locale = :ja
    config.add_autoload_paths_to_load_path = false

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        model_specs: true,
        request_specs: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Cookieを処理するmeddlewareを追加
    config.middleware.use ActionDispatch::Cookies

    # Flash
    config.middleware.use ActionDispatch::Flash

    # Cookieのsamesite属性を変更する(Rails v6.1~, :strict, :lax, :none)
    config.action_dispatch.cookies_same_site_protection =
    ENV["COOKIES_SAME_SITE"].to_sym if Rails.env.production?

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
  end
end
