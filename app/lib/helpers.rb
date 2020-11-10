# frozen_string_literal: true

# Candidates controller class
module Helpers
  # Authentification
  def current_user
    Users.find { |u| u.id == session[:user_id] } if session[:user_id]
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