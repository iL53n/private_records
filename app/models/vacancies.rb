# frozen_string_literal: true

# Vacancyes Class
class Vacancy
  include Mongoid::Document

  field :guid,          type: String
  field :is_closed,     type: Boolean
  field :name,          type: String
  field :position,      type: String
  field :position_type, type: String

  validates :guid,
            :name,
            :position,
            presence: true
  validates :guid, uniqueness: true

  scope :id,   ->(id)   { where(id: id) }
  scope :guid, ->(guid) { where(guid: guid) }

  has_many :candidates
end
