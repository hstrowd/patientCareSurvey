class SurveyQuestionType < ActiveRecord::Base
  validates :response_type, :response_class, presence: true, length: { maximum: 255 }
end
