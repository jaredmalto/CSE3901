# Load the Rails application.
require_relative 'application'

# Set up password resets
Rails.application.routes.default_url_options[:host] = 'localhost:3000'

# Initialize the Rails application.
Rails.application.initialize!
