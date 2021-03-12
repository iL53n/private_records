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

  def candidate_not_found!
    halt(404, { message: 'Кандидата с таким GUID не существует!' }.to_json) unless candidate
  end

  def serialize(candidate)
    CandidateSerializer.new(candidate).to_json
  end

  def to_json_with_filters(params)
    candidates = Candidate.all

    # we can add more filtering params in array
    # example: /api/v1/candidates?guid=123
    %i[id guid].each do |filter|
      candidates = candidates.send(filter, params[filter]) if params[filter]
    end

    candidates.map { |candidate| CandidateSerializer.new(candidate) }.to_json
  end

  # Candidate write methods
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
end
