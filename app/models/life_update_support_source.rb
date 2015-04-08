class LifeUpdateSupportSource < ActiveRecord::Base
  belongs_to :life_update
  lookup_for :support_source
end
