class ChooseBatch
  include ActiveModel::Model
  attr_accessor :batch_number
  validates :batch_number, presence: true
end
