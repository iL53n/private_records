# frozen_string_literal: true

# Candidates controller class
class CandidatesController < ApplicationController
  # index
  # TODO: add access restriction
  get '/' do
    @candidates = [Candidate.last]
    erb :index
  end

  # new
  get '/candidates/new' do
    @candidate = Candidate.new(new_candidate_params)
    erb :new
  end

  # create
  post '/candidates' do
    @candidate = Candidate.new(params[:candidate])
    @candidate.image = params[:image]

    if @candidate.save
      redirect '/' # "/show/#{@candidate.id}"
    else
      @error = error(@candidate)
      erb :new
    end
  end

  # show --> view after add new candidate's data
  get '/show/:id' do
    @candidate = Candidate.find(params[:id])
    erb :show
  end

  helpers do
    # Controller
    def new_candidate_params
      { guid: SecureRandom.uuid, created_at: Time.new }
    end

    def error(object)
      object.errors.full_messages.first
    end

    # API
    def base_url
      url_scheme = request.env['rack.url_scheme']
      http_host = request.env['HTTP_HOST']
      @base_url ||= "#{url_scheme}://#{http_host}"
    end

    def json_params
      JSON.parse(request.body.read)
    rescue StandardError => e
      halt(400, { message: 'Invalid JSON' }.to_json)
    end

    def candidate
      @candidate ||= Candidate.where(guid: params[:guid]).first
    end

    def candidate_not_found!
      halt(404, { message: 'Кандидата с таким GUID не существует!' }.to_json) unless candidate
    end

    def serialize(candidate)
      CandidateSerializer.new(candidate).to_json
    end
  end

  ####### API v1 #######
  namespace '/api/v1' do
    # before
    before do
      content_type 'application/json'
    end

    # INDEX
    get '/candidates/:date?' do
      candidates = Candidate.all

      # we can add more filtering params in array
      # example: /api/v1/candidates?guid=123
      %i[id guid].each do |filter|
        candidates = candidates.send(filter, params[filter]) if params[filter]
      end

      candidates.map { |candidate| CandidateSerializer.new(candidate) }.to_json
    end

    # SHOW
    get '/candidates/:guid' do
      candidate_not_found!
      serialize(candidate)
    end

    # CREATE
    post '/candidates' do
      candidate = Candidate.new(json_params)
      halt 422, serialize(candidate) unless candidate.save

      response.headers['Location'] = "#{base_url}/api/v1/#{candidate.id}"
      status 201
    end

    # UPDATE
    patch '/candidates/:guid' do
      candidate_not_found!
      halt 422, serialize(candidate) unless candidate.update_attributes(json_params)
      serialize(candidate)
    end

    # DELETE
    delete '/candidates/:guid' do
      candidate&.destroy
      status 204
    end
  end
end
