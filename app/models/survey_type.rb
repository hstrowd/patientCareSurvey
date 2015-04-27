class SurveyType < ActiveRecord::Base
  belongs_to :starting_step, class_name: 'SurveyStep'

  validates :survey_type, presence: true
end
