require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module New
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configure HTTP Basic Authentication
    config.middleware.use(Rack::Auth::Basic) do |username, password|
      ENV['ADMIN_USERNAME'] = username
      ENV['ADMIN_PASSWORD'] = password
      ENV['ADMIN_USERNAME'] == username && ENV['ADMIN_PASSWORD'] == password
    end
    
  end
end
