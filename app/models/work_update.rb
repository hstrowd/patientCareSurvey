class WorkUpdate < ActiveRecord::Base
  belongs_to :survey_response

  lookup_for :prior_employment_status, class_name: :employment_status
  lookup_for :current_employment_status, class_name: :employment_status
  lookup_for :max_education_level, class_name: :education_level

  validates :survey_response, presence: true
end
