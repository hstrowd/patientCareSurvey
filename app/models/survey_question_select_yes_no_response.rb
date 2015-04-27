class SurveyQuestionSelectYesNoResponse < ActiveRecord::Base
  belongs_to :survey_step_response
  belongs_to :question, class_name: 'SurveyQuestion'

  validates :survey_step_response, :question, presence: true

  def record(user_input)
    if user_input == 'true'
      self.response = true
    elsif user_input == 'false'
      self.response = false
    else
      self.response = nil
    end
  end

end
