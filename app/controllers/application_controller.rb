# frozen_string_literal: true

# App controller Class
class ApplicationController < Sinatra::Base
  register Sinatra::Namespace

  enable :inline_templates
  enable :sessions

  configure do
    require './app/lib/helpers'

    set :views, 'app/views'
    set :public_folder, '/public'
  end
end
