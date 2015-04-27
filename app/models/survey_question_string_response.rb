class SurveyQuestionStringResponse < ActiveRecord::Base
  belongs_to :survey_step_response
  belongs_to :question, class_name: 'SurveyQuestion'

  validates :survey_step_response, :question, presence: true
  validates :response, length: { maximum: 255 }

  def record(user_input)
    self.response = user_input
  end

end
