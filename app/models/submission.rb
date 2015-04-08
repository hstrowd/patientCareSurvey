class Submission < ActiveRecord::Base
  belongs_to :survey_response

  lookup_for :submission_step
  lookup_for :submission_action

  validates :submission_step, :submission_action, presence: true
  validates :params, length: { maximum: 5000 }
end
