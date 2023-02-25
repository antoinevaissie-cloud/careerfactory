class AddCampaignToBooking < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :campaign, index: true, null: false, foreign_key: true
  end
end
