# frozen_string_literal: true

require 'sinatra'
require 'mongoid'

# DB Setup
Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))

# Models
class Candidate
  include Mongoid::Document

  field :uid,        type: String
  field :first_name, type: String
  field :last_name,  type: String
  field :email,      type: String
  field :phone,      type: String

  validates :first_name,
            :last_name,
            :email,
            :phone,
            presence: true

  index({ uid: 1 }, { unique: true, name: 'uid_index' })
end

# Endpoints
get '/' do
  erb :show
end
