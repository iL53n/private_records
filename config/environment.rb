require 'bundler/setup'
Bundler.require

# DB Setup
# Mongoid.load!(File.join(File.dirname(__FILE__), 'mongoid.yml'))
Mongoid.load!(File.join('mongoid.yml'))

require_all 'app'
