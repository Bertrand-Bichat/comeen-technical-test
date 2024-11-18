# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# cli tasks
gem "foreman"

# Load env vars from file in DEV and TEST environments
gem "dotenv", groups: [:development, :test], require: "dotenv/load"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1"

# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 1.4"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors"
# Last modified at header, and general QoL
gem "responders"

# JSON API
gem "jsonapi.rb"

# State machine for models
gem "aasm"

## Auth
#
# User authentication
gem "devise"
# OAuth2 provider
gem "doorkeeper"
# Authorization
gem "pundit"

## Integrations
#
# Google Sheets Desk sync Integration
gem "google-apis-sheets_v4"
# calls APIs
gem "faraday"

# API documentation
gem "rswag-api"
gem "rswag-ui"

# Background jobs
gem "sidekiq"
gem "whenever", require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: [:mri, :mingw, :x64_mingw]

  gem "rspec", require: false
  gem "rspec-rails"
  gem "rswag-specs"

  gem "shoulda-matchers", "~> 5.0"

  gem "faker"
  gem "factory_bot_rails"
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-shopify", require: false
end
