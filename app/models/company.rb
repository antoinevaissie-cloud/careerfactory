class Company < ApplicationRecord
  has_one_attached :photo
  has_many :users
end
