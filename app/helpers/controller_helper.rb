module ApplicationHelpers
  def base_url
    url_scheme = request.env['rack.url_scheme']
    http_host = request.env['HTTP_HOST']
    @base_url ||= "#{url_scheme}://#{http_host}"
  end

  def json_params
    begin
      JSON.parse(request.body.read)
    rescue
      halt 400, { message: 'Invalid JSON' }.to_json
    end
  end

  def candidate
    @candidate ||= Candidate.where(guid: params[:guid]).first
  end

  def candidate_not_found!
    unless candidate
      halt(404, { message: 'Кандидата с таким GUID не существует!' }.to_json)
    end
  end

  def serialize(candidate)
    CandidateSerializer.new(candidate).to_json
  end
end
