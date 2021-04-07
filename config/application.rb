# frozen_string_literal: true

class Application < Sinatra::Base

  enable :inline_templates
  # enable :sessions
  use Rack::Session::Cookie, {
    key: 'rack.session',
    path: '/',
    secret: 'your_secret'
  }

  configure do
    register Sinatra::Namespace

    set :app_file, File.expand_path('../config.ru', __dir__)
    set :views, 'app/views'
    set :public_folder, 'public'
  end

  configure :development do
    register Sinatra::Reloader

    set :show_exceptions, false
  end
end
