class SurveyResponse < ActiveRecord::Base
  lookup_for :survey_type, symbolize: true

  belongs_to :user
  has_one :tumor_update
  has_one :work_update
  has_one :life_update
  has_one :health_update

  validates :survey_type, presence: true
end
