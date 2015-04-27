class SurveyStepResponse < ActiveRecord::Base
  belongs_to :survey_response
  belongs_to :step, class_name: 'SurveyStep'

  validates :survey_response, :step, presence: true
end
