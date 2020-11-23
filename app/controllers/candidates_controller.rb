# frozen_string_literal: true

# Candidates controller class
class CandidatesController < ApplicationController
  include Helpers

  # index
  get '/' do
    if user_signed_in?
      @candidates = Candidate.all # ToDo: don't use `all` in production
      erb :index
    else
      erb :login
    end
  end

  # new
  get '/candidates/new' do
    if user_signed_in?
      @candidate = Candidate.new
      intitalise_form_variables
      erb :new
    else
      @error = 'Добавление анкет доступно авторизированным пользователям!'
      erb :login
    end
  end

  # edit
  get '/candidates/:guid/edit' do
    if candidate
      intitalise_form_variables
      erb :edit
    else
      erb '<h5>Не найдена анкета или срок жизни истек!</h5>' # ToDo: need other way if we can problem
    end
  end

  # create
  post '/candidates' do
    @candidate = Candidate.new(params[:candidate])

    if @candidate.save
      erb :mailto
    else
      @error = error(candidate)
      erb :new
    end
  end

  # update
  post '/candidates/:guid' do
    erb '<h5>Не верный запрос!</h5>' unless params[:_method] && params[:_method] == 'patch' # ToDo: destroy in production

    @candidate = candidate
    @candidate.update(params[:candidate])
    @candidate.image = params[:image] if !candidate[:image_identifier] && params[:image]
    add_arrays_to_candidate(@candidate, params) # ToDo: need refactoring

    if @candidate.save
      erb :show
    else
      @error = error(@candidate)
      intitalise_form_variables
      erb :edit
    end
  end

  # delete
  post '/candidates/:guid/delete' do
    candidate&.destroy
    redirect to '/'
  end

  # show --> view after add new candidates's data
  get '/show/:id' do
    @candidate = Candidate.find(params[:id])
    erb :show
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
