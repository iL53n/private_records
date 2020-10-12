class CandidateSerializer
  def initialize(candidate)
    @candidate = candidate
  end

  def as_json(*)
    data = {
      # id: @candidate.id.to_s,
      guid: @candidate.guid,
      first_name: @candidate.first_name,
      last_name: @candidate.last_name,
      email: @candidate.email,
      phone: @candidate.phone
    }
    data[:errors] = @candidate.errors if @candidate.errors.any?
    data
  end
end
