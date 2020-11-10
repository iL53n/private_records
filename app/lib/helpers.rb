# frozen_string_literal: true

# Candidates controller class
module Helpers
# Authentification
def current_user
Users.find { |u| u.id == session[:user_id] } if session[:user_id]
end

def user_signed_in?
!!current_user
end

def hash_password(password)
BCrypt::Password.create(password).to_s
end

def test_password(password, hash)
BCrypt::Password.new(hash) == password
end
end