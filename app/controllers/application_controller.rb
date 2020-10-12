# require 'sinatra'
# require 'sinatra/namespace'

class ApplicationController < Sinatra::Base
  # helpers ApplicationHelpers

  configure do
    set :views, 'app/views'
    set :public_folder, '/public'
  end
end
