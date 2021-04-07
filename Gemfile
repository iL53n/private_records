# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'rake', '~> 13.0.1'
gem 'puma', '~> 4.3.0'

gem 'sinatra', '~> 2.0.0', require: 'sinatra/base'
gem 'sinatra-contrib', '~> 2.0.0'
gem 'faraday', '~> 1.0.1'
gem 'faraday_middleware', '~> 1.0.0'

gem 'russian'
gem 'bcrypt', '~> 3.1'
gem 'config', '~> 2.2.1'

gem 'mongoid'
gem 'carrierwave', '~> 1.0'
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'

gem 'dry-initializer', '~> 3.0.3'
gem 'dry-validation', '~> 1.5.0'

gem 'activesupport', '~> 6.0.0', require: false
gem 'fast_jsonapi', '~> 1.5'

group :test do
  gem 'rspec', '~> 3.9.0'
  gem 'factory_bot', '~> 5.2.0'
  gem 'rack-test', '~> 1.1.0'
  gem 'database_cleaner-sequel', '~> 1.8.0'
end
