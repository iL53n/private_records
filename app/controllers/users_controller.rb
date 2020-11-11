# frozen_string_literal: true

# Users Controller class
class UsersController < ApplicationController
  include Helpers

  get '/login' do
    erb :login
  end

  get '/users/new' do
    @user = User.new({ id: 0, username: '', email: '', password_digest: '', active: false, is_admin: false })
    erb :user_new
  end
end
