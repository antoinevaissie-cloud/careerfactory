class Campaign < ApplicationRecord
  has_many :campaign_candidates

  has_many :campaign_recruiters


end
