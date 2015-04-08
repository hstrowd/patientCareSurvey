class HealthUpdate < ActiveRecord::Base
  belongs_to :survey_response

  validates :survey_response, presence: true
end
