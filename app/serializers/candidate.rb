# frozen_string_literal: true

# CandidateSerializer Class
class CandidateSerializer
  def initialize(candidate)
    @candidate = candidate
  end

  def as_json(data={})
    data[:object] = @candidate
    data[:errors] = @candidate.errors if @candidate.errors.any?

    data
  end

  # for filtering
  # def as_json(data={}, *args)
  #   %i[args].each do |attr|
  #     data[attr] = @candidate[attr]
  #   end
  #   data[:errors] = @candidate.errors if @candidate.errors.any?
  #
  #   data
  # end
end
