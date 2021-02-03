# frozen_string_literal: true

# Candidate Class
class Candidate
  include Mongoid::Document
  include Attachments

  def initialize(params=nil)
    super(params)
    self.guid ||= SecureRandom.uuid
    self.created_at ||= Time.new
    self.last_job_like_dislike ||= []
    self.work_experience_areas ||= []
    self.desired_pay_system ||= []
  end

  field :guid,                         type: String
  field :position,                     type: String
  field :first_name,                   type: String
  field :last_name,                    type: String
  field :sur_name,                     type: String
  field :date,                         type: Date
  field :city,                         type: String
  field :material_status,              type: String
  field :conditions,                   type: String
  field :passport_serial,              type: String
  field :passport_number,              type: String
  field :nationality,                  type: String
  field :private_number,               type: String
  field :passport_dep,                 type: String
  field :passport_date,                type: Date
  field :email,                        type: String
  field :phone,                        type: String
  field :created_at,                   type: DateTime
  field :military_registration,        type: String
  field :relatives,                    type: Array # {type:'',name:'',date:'',job:'',adr:''}
  field :registration_city,            type: String
  field :registration_street,          type: String
  field :registration_house,           type: String
  field :registration_apartment,       type: String
  field :residence_city,               type: String
  field :residence_street,             type: String
  field :residence_house,              type: String
  field :residence_apartment,          type: String
  field :drivers_license,              type: String
  field :having_a_car,                 type: String
  field :political_membership,         type: String
  field :conviction,                   type: String
  field :name_of_the_institution,      type: String
  field :diploma_specialty,            type: String
  field :year_of_admission,            type: Date
  field :year_of_ending,               type: Date
  field :form_of_education,            type: String
  field :education,                    type: Array # {begin:'',end:'',inst:'',spec:'',form:''}
  field :extra,                        type: Array # {year:0,inst:'',name:'',duration:0}
  field :language,                     type: Array # {name:'',orally:0,writing:0}
  field :word_level,                   type: String
  field :excel_level,                  type: String
  field :access_level,                 type: String
  field :_1c_level,                    type: String
  field :other_skills_level,           type: String
  field :extra_skills,                 type: String
  field :experience,                   type: Array # {name:'',pos:'',field:'',conds:'',dism:'',period:'',workers:0,subords:0,duties:''}
  field :reccomenders,                 type: Array # {name:'',job:'',position:'',phone:''}
  field :last_job_like_dislike,        type: Array # %w[ls upct llbo drwm ncp emr ow so]
  field :work_experience_areas,        type: Array # %w[so prod serv whsal ret publ pc build tr ent]
  field :work_experience_areas_other,  type: String
  field :hobbies,                      type: String
  field :personality_strengths,        type: String
  field :acceptable_working_schedule,  type: String
  field :job_choice_reason,            type: String
  field :work_debufs,                  type: String
  field :trial_period_salaries,        type: Integer
  field :post_trial_salaries,          type: Integer
  field :desired_pay_system,           type: Array # %w[sal salbon int salint]
  field :additional_income,            type: String
  field :overtime_work,                type: Integer
  field :business_trips,               type: Integer
  field :training,                     type: Integer
  field :ready_to_start_work,          type: Date
  field :about_yourself,               type: String
  field :date_of_filling,              type: Date
  field :age,                          type: Integer
  field :bad_habits,                   type: String
  field :avg_income,                   type: Integer
  field :health_status,                type: String
  field :previous_conviction,          type: String
  field :administrative_penalties,     type: String
  field :orders_of_execution,          type: String
  field :job_disciplinary_penalties,   type: String
  field :job_data_source,              type: String
  field :data_verification,            type: Boolean
  field :author_email,                 type: String

  mount_uploader :image, ImageUploader, type: String

  validates :guid,
            :position,
            :first_name,
            :last_name,
            :sur_name,
            :date,
            :phone,
            :email,
            presence: true

  index({ guid: 1 }, { unique: true, name: 'guid_index' })

  scope :id,   ->(id)   { where(id: id) }
  scope :guid, ->(guid) { where(guid: guid) }
end
