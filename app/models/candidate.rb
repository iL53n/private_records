# DB Setup
# Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))

class Candidate
  include Mongoid::Document

  field :guid,       type: String
  field :first_name, type: String
  field :last_name,  type: String
  field :email,      type: String
  field :phone,      type: String

  validates :guid,
            # :first_name,
            # :last_name,
            # :email,
            # :phone,
            presence: true

  index({ guid: 1 }, { unique: true, name: 'guid_index' })

  scope :id,   ->(id)   { where(id: id) }
  scope :guid, ->(guid) { where(guid: guid) }
end
