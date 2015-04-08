class User < ActiveRecord::Base
  lookup_for :gender
  lookup_for :ethnicity

  validates :first_name, :last_name, :birth_date, presence: true
  validates :first_name, :last_name, length: { maximum: 255 }
  validates :birth_date, presence: true, date: { on_or_after: :birth_date_first, on_or_before: :birth_date_last }
  # TODO: Add validation for other gender and other race responses.

  def self.birth_date_first
    118.years.ago
  end

  def self.birth_date_last
    0.days.ago
  end

  def duplicates
    dup_attrs = {
      first_name: self.first_name,
      last_name: self.last_name,
      birth_date: self.birth_date
    };
    User.where(dup_attrs)
  end

  def duplicate?
    !duplicates.empty?
  end

  def last_update
    last_submission = SurveyResponse.where(user: self).order(updated_at: :desc).limit(1)
    if !last_submission.empty?
      return last_submission.first.updated_at
    else
      return self.created_at
    end
  end

end
