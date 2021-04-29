# frozen_string_literal: true

# API Class
class AdRoutes < ApplicationController
  include Helpers

  ####### API v1 #######
  namespace '/api/v1' do
    # before
    before do
      unless request.env['HTTP_API_KEY'] && request.env['HTTP_API_KEY'] == ENV['API_KEY']
        halt 401, '401 Unauthorized'
        content_type 'application/json'
      end
    end

    # Candidates

    # INDEX
    get '/candidates/' do
      to_json_with_filters(params, Candidate)
    end

    # SHOW
    get '/candidates/:guid' do
      candidate_not_found!
      serialize(candidate)
    end

    # CREATE
    post '/candidates/' do
      create_object(json_params, Candidate)
    end

    # UPDATE
    patch '/candidates/:guid' do
      candidate_not_found!
      update_object(candidate, json_params)
    end

    # DELETE
    delete '/candidates/:guid' do
      candidate&.destroy
      status 204
    end

    # Vacancies

    # INDEX
    get '/vacancies/' do
      to_json_with_filters(params, Vacancy)
    end

    # SHOW
    get '/vacancies/:guid' do
      vacancy_not_found!
      serialize(vacancy)
    end

    # CREATE
    post '/vacancies/' do
      create_object(json_params, Vacancy)
    end

    # UPDATE
    patch '/vacancies/:guid' do
      vacancy_not_found!
      update_object(vacancy, json_params)
    end

    # DELETE
    delete '/vacancies/:guid' do
      vacancy&.destroy
      status 204
    end
  end
end
