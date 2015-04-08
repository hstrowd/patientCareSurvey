class LifeUpdate < ActiveRecord::Base
  belongs_to :survey_response

  lookup_for :depressed_rating, class_name: :agreement_rating, symbolize: true
  lookup_for :hope_rating, class_name: :agreement_rating
  lookup_for :spiritual_rating, class_name: :agreement_rating

  has_many :life_update_support_sources
  has_many :support_sources, through: :life_update_support_sources

  validates :survey_response, presence: true
end
