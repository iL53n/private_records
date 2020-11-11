# frozen_string_literal: true

# Candidates controller class
class CandidatesController < ApplicationController
  include Helpers

  # index
  # TODO: add access restriction
  get '/' do
    @candidates = [Candidate.last] # TODO: Select all candidates in Prod
    erb :index
  end

  # new
  get '/candidates/new' do
    if user_signed_in?
      @candidate = Candidate.new(new_candidate_params)

      @last_job_like_dislike_params = last_job_like_dislike_params
      @work_experience_areas        = work_experience_areas
      @desired_pay_system           = desired_pay_system

      erb :new
    else
      @error = 'Добавление анкет доступно авторизированным пользователям!'
      @candidates = [Candidate.last] # TODO: Select all candidates in Prod
      erb :index
    end
  end

  # create
  post '/candidates' do
    @candidate = Candidate.new(params[:candidate])
    @candidate.image = params[:image]

    add_arrays_to_candidate(@candidate, params)

    puts params

    if @candidate.save
      redirect '/' # "/show/#{@candidates.id}"
    else
      @error = error(@candidate)

      @candidate.last_job_like_dislike = [] if @candidate.last_job_like_dislike.nil?
      @candidate.work_experience_areas = [] if @candidate.work_experience_areas.nil?

      @last_job_like_dislike_params = last_job_like_dislike_params
      @work_experience_areas        = work_experience_areas
      @desired_pay_system           = desired_pay_system

      erb :new
    end
  end

  # show --> view after add new candidates's data
  get '/show/:id' do
    @candidate = Candidate.find(params[:id])
    erb :show
  end

  helpers do
    # Controller
    def new_candidate_params
      {
        guid: SecureRandom.uuid,
        date: Time.new,
        created_at: Time.new,
        last_job_like_dislike: [],
        work_experience_areas: []
      }
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
