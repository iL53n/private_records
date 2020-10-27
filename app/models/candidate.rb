# frozen_string_literal: true

# Candidate Class
class Candidate
  include Mongoid::Document

  # Common fields
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
  field :registration_city,            type: String
  field :military_registration,        type: String
  field :relatives,                    type: Array # {type:'',f_name:'',l_name:'',s_name:'',date:'',pl:'',job:'',adr:''}
  field :registration_city,            type: String
  field :registration_street,          type: String
  field :registration_house,           type: String
  field :registration_apartment,       type: String
  field :residence_city,               type: String
  field :residence_street,             type: String
  field :residence_house,              type: String
  field :residence_apartment,          type: String
  field :relative_surname,             type: String
  field :relative_name,                type: String
  field :relative_patronymic,          type: String
  field :relative_place_of_birth,      type: String
  field :relative_place_of_work,       type: String
  field :relative_position,            type: String
  field :relative_city,                type: String
  field :relative_street,              type: String
  field :relative_house,               type: String
  field :relative_apartment,           type: String
  field :drivers_license,              type: String
  field :driving_experience,           type: String
  field :having_a_car,                 type: String
  field :political_membership,         type: String
  field :conviction,                   type: String
  field :name_of_the_institution,      type: String
  field :diploma_specialty,            type: String
  field :year_of_admission,            type: Date
  field :year_of_ending,               type: Date
  field :form_of_education,            type: String
  field :extra_year_of_study,          type: Date
  field :extra_institution,            type: String
  field :extra_course_name,            type: String
  field :extra_duration,               type: String
  field :extra_specialty,              type: String
  field :language,                     type: String
  field :language_level_orally,        type: String
  field :language_level_writing,       type: String
  field :word_level,                   type: String
  field :excel_level,                  type: String
  field :access_level,                 type: String
  field :_1c_level,                    type: String
  field :other_skills_level,           type: String
  field :extra_skills,                 type: String
  field :experience_company_name,      type: String
  field :experience_position,          type: String
  field :experience_position,          type: Date
  field :receipt_date,                 type: Date
  field :dismissal_data,               type: String
  field :experience,                   type: Array # {conds:'',dism:'',begin:'',end:'',workers:0,subords:0,duties:0}
  field :reccomenders,                 type: Array # {f_name:'',l_name:'',s_name:'',job:'',pos:'',phone:''}
  field :last_job_like_dislike,        type: Array # [:LS,:UPCT,:LLBO,:DRWM,:NCP,:EMR,:OW,:SO]
  field :work_experience_areas,        type: Array # [:SO,:PROD,:SERV,:WHSAL,:RET,:PUBL,:PC,:BUILD,:TR,:ENT]
  field :work_experience_areas_other,  type: String
  field :hobbies,                      type: String
  field :personality_strengths,        type: String
  field :acceptable_working_schedule,  type: String
  field :job_choice_reason,            type: String
  field :work_debufs,                  type: String
  field :trial_period_salaries,        type: Integer
  field :post_trial_salaries,          type: Integer
  field :SAL,                          type: Boolean
  field :SALBON,                       type: Boolean
  field :INT,                          type: Boolean
  field :SALINT,                       type: Boolean
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

  validates :guid,
            :first_name,
            :last_name,
            :email,
            :phone,
            presence: true

  index({ guid: 1 }, { unique: true, name: 'guid_index' })

  scope :id,   ->(id)   { where(id: id) }
  scope :guid, ->(guid) { where(guid: guid) }
end
