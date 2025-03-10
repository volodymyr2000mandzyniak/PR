source "https://rubygems.org"

# Core Rails gems
gem "rails", "~> 7.2.2", ">= 7.2.2.1"
gem "puma", ">= 5.0"
gem "pg", "~> 1.1"
gem "tzinfo-data", platforms: %i[windows jruby]
gem "bootsnap", require: false

# Middleware and security
gem "rack-attack"

# Serialization
gem "active_model_serializers"

gem 'devise'
gem 'simple_token_authentication'
gem 'devise-jwt'
gem 'rack-cors'

# Development and test groups
group :development, :test do
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "factory_bot_rails"
  gem "faker"
end

group :test do
  gem "rspec-rails"
  gem "rack-test"
end