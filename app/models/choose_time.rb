class ChooseTime
  include ActiveModel::Model
  attr_accessor :start_date, :end_date, :slot_size

  validates :start_date, :end_date, :slot_size, presence: true
end
