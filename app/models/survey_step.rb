class SurveyStep < ActiveRecord::Base
  belongs_to :survey_type
  belongs_to :next_step, class_name: 'SurveyStep'
  # TODO: Look for a more concise way to specify this foreign key.
  has_one :previous_step, class_name: 'SurveyStep', foreign_key: :next_step_id
  has_many :questions, -> { order "sequence ASC" }, class_name: 'SurveyQuestion'

  validates :name, presence: true
  validates :name, :custom_action, length: { maximum: 255 }
  validates :intro, length: { maximum: 1000 }

  # Returns an all lowercase version of the name with spaces replaced with dashes.
  def slug
    self.name.downcase.dasherize.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

end
