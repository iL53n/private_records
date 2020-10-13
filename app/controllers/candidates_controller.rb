class CandidatesController < ApplicationController
  get '/' do
    erb :show
  end

  namespace '/api/v1' do
    # before
    before do
      content_type 'application/json'
    end

    # INDEX
    get '/candidates' do
      candidates = Candidate.all

      # we can add more filtering params in array
      # example: /api/v1/candidates?guid=123
      [:id, :guid].each do |filter|
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

    # helpers
    helpers do
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
  end
end


