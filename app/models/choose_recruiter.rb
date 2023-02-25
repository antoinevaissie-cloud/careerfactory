class ChooseRecruiter
  include ActiveModel::Model
  attr_accessor :user_ids
  validates :user_ids, presence: true
end
