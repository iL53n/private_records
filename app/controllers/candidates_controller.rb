# frozen_string_literal: true

# Candidates controller class
class CandidatesController < ApplicationController
  include Abbreviations
  include Helpers

  # index
  get '/' do
    if user_signed_in?
      @candidates = Candidate.all # TODO: don't use `all` in production
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
      @vacancies = Vacancy.all
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
      if candidate[:active] && candidate.active || user_signed_in?
        get_view_for_type(:edit, @candidate[:position_type])
      else
        erb "<% @error = 'Дальнейшее редактирование анкеты доступно авторизированным пользователям!' %>"
      end
    else
      erb "<% @error = 'Не найдена анкета или срок жизни истек!' %>"
    end
  end

  # create
  post '/candidates' do
    vacancy_guid = params[:candidate][:position]
    @vacancy = Vacancy.where(guid: vacancy_guid).first

    params[:candidate][:position] = @vacancy.position if @vacancy
    params[:candidate][:position_type] = @vacancy.position_type if @vacancy

    @candidate = Candidate.new(params[:candidate])
    @candidate.vacancy = @vacancy

    if @candidate.save
      @message_success = 'Анкета кандидата успешно создана'
      erb :mailto
    else
      params[:candidate][:position] = vacancy_guid if @vacancy

      @vacancies = Vacancy.all
      @error = error(candidate)
      erb :new
    end
  end

  # update
  post '/candidates/:guid' do
    if !params[:_method] || params[:_method] != 'patch' # TODO: destroy in prod.
      erb "<% @error = 'Не верный запрос!' %>"
    end

    params[:candidate][:last_job_like_dislike] ||= [] # TODO: try to remove this
    params[:candidate][:work_experience_areas] ||= []
    params[:candidate][:desired_pay_system] ||= []

    params[:candidate][:created_at] = Time.new

    @candidate = candidate
    @candidate.update(params[:candidate])
    @candidate.image = params[:image] if !candidate[:image_identifier] && params[:image]
    add_arrays_to_candidate(@candidate, params) # TODO: need refactoring

    if @candidate.save
      @message_success = if user_signed_in?
                           'Данные сохранены.'
                         elsif @candidate.active?
                           'Данные сохранены. Вы можете вернуться к редактированию анкеты.<br />
                            Рекрутер получит вашу анкету только если вы нажмёте кнопку "Отправить данные"'
                         else
                           "Спасибо, #{@candidate.first_name} #{@candidate.last_name}, за заполнение анкеты!"
                         end

      erb :show
    else
      @error = error(@candidate)
      intitalise_form_variables
      get_view_for_type(:edit, @candidate[:position_type])
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
end
