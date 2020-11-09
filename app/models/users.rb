# frozen_string_literal: true

# User Class
class User
  include Mongoid::Document

  field :id,       type: Integer
  field :username, type: String
  field :password, type: String

  validates :username, presence: true
  validates :username, uniqueness: true
end
