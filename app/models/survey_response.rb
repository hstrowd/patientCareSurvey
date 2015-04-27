class SurveyResponse < ActiveRecord::Base
  belongs_to :survey_type
  belongs_to :user
  has_many :step_responses, class_name: 'SurveyStepResponse'

  validates :survey_type, presence: true
end
