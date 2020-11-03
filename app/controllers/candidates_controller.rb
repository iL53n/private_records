# frozen_string_literal: true

# Candidates controller class
class CandidatesController < ApplicationController
  # index
  # TODO: add access restriction
  get '/' do
    @candidates = [Candidate.last] # TODO: Select all candidates in Prod
    erb :index
  end

  # new
  get '/candidates/new' do
    @candidate = Candidate.new(new_candidate_params)

    @last_job_like_dislike_params = last_job_like_dislike_params
    @work_experience_areas        = work_experience_areas
    @desired_pay_system           = desired_pay_system

    erb :new
  end

  # create
  post '/candidates' do
    @candidate = Candidate.new(params[:candidate])
    @candidate.image = params[:image]

    add_arrays_to_candidate(@candidate, params)

    puts params

    if @candidate.save
      redirect '/' # "/show/#{@candidate.id}"
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

  # show --> view after add new candidate's data
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

    def error(object)
      object.errors.full_messages.first
    end

    # fill by params
    # TODO: need refactoring(we must use: https://mongomapper.com/documentation/plugins/associations.html#many-to-many)
    def add_arrays_to_candidate(candidate, params)
      tables_names.each do |table_name, ver_field|
        arr = []
        params.select { |key| key == table_name }.each_value do |table|
          table.each_value do |row|
            arr << row unless row[ver_field] == ''
          end
        end
        candidate[table_name] = arr
      end
    end

    def tables_names
      {
        'relatives' => :name,
        'education' => :inst,
        'extra' => :name,
        'language' => :name,
        'experience' => :name,
        'reccomenders' => :name
      }
    end

    def last_job_like_dislike_params
      {
        'ls' => 'Низкая зарплата',
        'upct' => 'Неудовлетворительный психологический климат в коллективе',
        'llbo' => 'Невысокий уровень организации дела',
        'drvm' => 'Сложные отношения с руководством',
        'ncp' => 'Нет перспективы должностного роста',
        'emr' => 'Чрезмерно высокие требования руководства',
        'ow' => 'Сверхурочная работа',
        'so' => 'Что-то другое'
      }
    end

    def work_experience_areas
      {
        'prod' => 'Производство',
        'serv' => 'Услуги',
        'whsal' => 'Оптовая торговля',
        'ret' => 'Розничная торговля',
        'publ' => 'Издательство',
        'pc' => 'Общепит',
        'build' => 'Строительство',
        'tr' => 'Транспорт',
        'ent' => 'Индивидуальный предприниматель'
      }
    end

    def desired_pay_system
      {
        sal: 'Оклад',
        salbon: 'Оклад+премия',
        int: 'Процент',
        salint: 'Оклад+процент'
      }
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
