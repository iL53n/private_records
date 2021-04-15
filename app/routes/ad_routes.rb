# frozen_string_literal: true

# API Class
class AdRoutes < ApplicationController
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
    get '/candidates/:date?' do
      to_json_with_filters(params)
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

    # Vacancies

    # INDEX
    get '/vacancies/' do
      vacancies = Vacancy.all

      %i[id guid].each do |filter|
        vacancies = vacancies.send(filter, params[filter]) if params[filter]
      end

      vacancies.map { |vacancy| vacancy }.to_json
    end

    # SHOW
    get '/vacancies/:guid' do
      vacancy ||= Vacancy.where(guid: params[:guid]).first
      halt(404, { message: 'Вакансии с таким GUID не существует!' }.to_json) unless vacancy

      vacancy.to_json
    end

    # CREATE
    post '/vacancies' do
      vacancy = Vacancy.new(json_params)
      halt 422, serialize(vacancy) unless vacancy.save

      response.headers['Location'] = "#{base_url}/api/v1/#{vacancy.id}"
      status 201
    end

    # UPDATE
    patch '/vacancies/:guid' do
      # vacancy ||= Vacancy.where(guid: params[:guid]).first
      # halt(404, { message: 'Вакансии с таким GUID не существует!' }.to_json) unless vacancy
      # halt 422, serialize(vacancy) unless vacancy.update_attributes(json_params)
      # serialize(vacancy)
      status 200
    end

    # DELETE
    delete '/vacancies/:guid' do
      vacancy ||= Vacancy.where(guid: params[:guid]).first
      vacancy&.destroy
      status 204
    end
  end
end
