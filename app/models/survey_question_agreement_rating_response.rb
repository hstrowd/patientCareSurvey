class SurveyQuestionAgreementRatingResponse < ActiveRecord::Base
  belongs_to :survey_step_response
  belongs_to :question, class_name: 'SurveyQuestion'
  lookup_for :response, class_name: 'AgreementRating'

  validates :survey_step_response, :question, presence: true

  def record(user_input)
    self.response = AgreementRating[user_input]
  end

end
