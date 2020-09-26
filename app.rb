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

  scope :id,  ->(id)  { where(id: id) }
  scope :uid, ->(uid) { where(uid: uid) }
end

# Serializers
class CandidateSerializer
  def initialize(candidate)
    @candidate = candidate
  end

  def as_json(*)
    data = {
      # id: @candidate.id.to_s,
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
  # before
  before do
    content_type 'application/json'
  end

  # helpers
  helpers do
    def base_url
      @base_url ||= "
      #{request.env['rack.url_scheme']}://{request.env['HTTP_HOST']}
                    "
    end

    def json_params
      begin
        JSON.parse(request.body.read)
      rescue
        halt 400, { message: 'Invalid JSON' }.to_json
      end
    end
  end

  # index
  get '/candidates' do
    candidates = Candidate.all

    # we can add more filtering params in array
    # example: /api/v1/candidates?uid=123
    [:id, :uid].each do |filter|
      candidates = candidates.send(filter, params[filter]) if params[filter]
    end

    candidates.map { |candidate| CandidateSerializer.new(candidate) }.to_json
  end

  # show
  get '/candidates/:uid' do |uid|
    candidate = Candidate.where(uid: uid).first
    unless candidate
      halt(404, { message: 'Кандидата с таким UID не существует!' }.to_json)
    end
    CandidateSerializer.new(candidate).to_json
  end

  # create


  # update


  # delete
end
