# frozen_string_literal: true

# CandidateSerializer Class
class CandidateSerializer
  def initialize(candidate)
    @candidate = candidate
  end

  def basic_object(*)
    data = {}
    data[:object] = @candidate
    data[:errors] = @candidate.errors if @candidate.errors.any?
    data
  end

  def as_json(*)
    basic_object
  end

  def only_basic(*)
    data = {}
    %i[guid first_name last_name email phone].each do |attr|
      data[attr] = @candidate[attr]
    end

    data[:errors] = @candidate.errors if @candidate.errors.any?
    data
  end
end


