class TumorUpdate < ActiveRecord::Base
  belongs_to :survey_response

  validates :survey_response, presence: true
  validates :diagnosis,  length: { maximum: 5000 }
  validates :chemo_type, length: { maximum: 255 }
  validates :seizure_count, :steroid_dose, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
