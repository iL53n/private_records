# DB Setup
# Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))

class Candidate
  include Mongoid::Document

  field :guid,                  type: String
  field :position,              type: String
  field :first_name,            type: String
  field :last_name,             type: String
  field :sur_name,              type: String
  field :date,                  type: Date
  field :city,                  type: String
  field :material_status,       type: String
  field :conditions,            type: String
  field :children,              type: String
  field :passport_serial,       type: String
  field :passport_number,       type: String
  field :nationality,           type: String
  field :private_number,        type: String
  field :passport_dep,          type: String
  field :passport_date,         type: Date
  field :email,                 type: String
  field :phone,                 type: String
  field :created_at,            type: DateTime

  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates :email, presence: true
  # validates :phone, presence: true

  index({ guid: 1 }, { unique: true, name: 'guid_index' })

  scope :id,   ->(id)   { where(id: id) }
  scope :guid, ->(guid) { where(guid: guid) }
end
