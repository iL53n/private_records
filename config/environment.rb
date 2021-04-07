ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require

require_relative 'application_loader'
ApplicationLoader.load_app!
