class SurveyQuestion < ActiveRecord::Base
  belongs_to :survey_step
  belongs_to :question_type, class_name: 'SurveyQuestionType'

  validates :name, :question, :name, :question, :sequence, presence: true
  validates :name, length: { maximum: 255 }
  validates :question, length: { maximum: 1000 }
  validates :name, :sequence, uniqueness: { scope: :survey_step }
end
