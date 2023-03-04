class Campaign < ApplicationRecord
  has_many :campaign_users, dependent: :destroy
  has_many :users, through: :campaign_users
  has_many :bookings, dependent: :destroy
  CATEGORIES = ["Ruby", "JavaScript", "CSS"]
end
