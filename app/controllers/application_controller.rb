# frozen_string_literal: true
require 'sinatra/support/i18nsupport'

# App controller Class
class ApplicationController < Sinatra::Base
  register Sinatra::Namespace
  register Sinatra::I18nSupport

  load_locales './config/locales'
  set :default_locale, 'ru' # Optional; defaults to 'en'
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
