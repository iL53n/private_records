# frozen_string_literal: true

# User Class
class User
  include Mongoid::Document

  field :username,        type: String
  field :email,           type: String
  field :password_digest, type: String
  field :active,          type: Boolean
  field :is_admin,        type: Boolean

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :email, presence: true
  validates :email, uniqueness: true
end
