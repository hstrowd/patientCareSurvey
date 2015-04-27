class Submission < ActiveRecord::Base
  belongs_to :survey_response
  belongs_to :step, class_name: 'SurveyStep'
  lookup_for :action, class_name: 'SurveyAction'

  validates :survey_response, :step, :action, presence: true
  validates :params, length: { maximum: 5000 }
end
