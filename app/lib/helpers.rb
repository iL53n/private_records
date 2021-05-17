# frozen_string_literal: true

# Helpers methods
module Helpers
  # Authentification
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    !!current_user
  end

  def hash_password(password)
    BCrypt::Password.create(password).to_s
  end

  def test_password(password, hash)
    BCrypt::Password.new(hash) == password
  end

  # API
  def base_url
    url_scheme = request.env['rack.url_scheme']
    http_host = request.env['HTTP_HOST']
    @base_url ||= "#{url_scheme}://#{http_host}"
  end

  def json_params
    JSON.parse(request.body.read)
  rescue StandardError
    halt(400, { message: 'Invalid JSON' }.to_json)
  end

  def candidate
    @candidate ||= Candidate.where(guid: params[:guid]).first
  end

  def vacancy
    @vacancy ||= Vacancy.where(guid: params[:guid]).first
  end

  def candidate_not_found!
    halt(404, { message: 'Кандидата с таким GUID не существует!' }.to_json) unless candidate
  end

  def vacancy_not_found!
    halt(404, { message: 'Вакансии с таким GUID не существует!' }.to_json) unless vacancy
  end

  def serialize(candidate)
    CandidateSerializer.new(candidate).to_json
  end

  def to_json_with_filters(params, manager)
    objcts = manager.all

    %i[id guid updated_after].each do |filter| # TODO: syncid, as param to return latest changes
      objcts = objcts.send(filter, params[filter]) if params[filter]
    end

    objcts.map { |objct| CandidateSerializer.new(objct) }.to_json
  end

  def create_object(json_params, manager)
    ojct = manager.new(json_params)
    halt 422, serialize(ojct) unless ojct.save

    response.headers['Location'] = "#{base_url}/api/v1/#{ojct.id}"
    status 201
  end

  def update_object(objct, json_params)
    halt 422, serialize(objct) unless objct.update_attributes(json_params)
    serialize(objct)
  end

  # Candidate write methods
  def error(object)
    # object.errors.full_messages.first
    error_texts = []
    object.errors.each do |k, v|
      error_text = t("candidate.error.#{k}")
      error_text = "#{k} #{v}" unless error_text.index('translation missing:').nil?
      error_texts << error_text
    end
    error_texts[0] unless error_texts.empty?
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

  # Candidate types (worker/spec)
  def get_view_for_type(view_page, type)
    if type == 'worker'
      same_pages = {
        edit: :edit_worker
      }

      page_from_type = same_pages[view_page]
      view_page = page_from_type if page_from_type
    end

    erb view_page
  end
end
