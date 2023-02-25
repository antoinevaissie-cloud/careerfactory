class Booking < ApplicationRecord
  belongs_to :candidate, class_name: 'User'
  belongs_to :recruiter, class_name: 'User'
  belongs_to :campaign
end
