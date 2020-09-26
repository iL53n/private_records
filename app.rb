# frozen_string_literal: true

require 'sinatra'
require 'sinatra/namespace'
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

  scope :uid, ->(uid) { where(uid: uid) }
end

# Serializers
class CandidateSerializer
  def initialize(candidate)
    @candidate = candidate
  end

  def as_json(*)
    data = {
      id: @candidate.id.to_s,
      uid: @candidate.uid,
      first_name: @candidate.first_name,
      last_name: @candidate.last_name,
      email: @candidate.email,
      phone: @candidate.phone
    }
    data[:errors] = @candidate.errors if @candidate.errors.any?
    data
  end
end

# Endpoints
get '/' do
  erb :show
end

namespace '/api/v1' do
  before do
    content_type 'application/json'
  end

  get '/candidates' do
    candidates = Candidate.all

    # we can add more params in array
    # example: /api/v1/candidates?uid=123
    [:uid].each do |filter|
      candidates = candidates.send(filter, params[filter]) if params[filter]
    end

    candidates.map { |candidate| CandidateSerializer.new(candidate) }.to_json
  end
end
