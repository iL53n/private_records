# frozen_string_literal: true

# App controller Class
class ApplicationController < Sinatra::Base
  register Sinatra::Namespace

  enable :inline_templates
  # enable :sessions
  use Rack::Session::Cookie, {
    key: 'rack.session',
    path: '/',
    secret: 'your_secret'
  }

  configure do
    require './app/lib/helpers'
    require './app/lib/abbreviations'

    set :views, 'app/views'
    set :public_folder, 'public'
  end
end
