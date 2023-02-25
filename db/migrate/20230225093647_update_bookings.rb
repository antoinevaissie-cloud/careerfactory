class UpdateBookings < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :campaign_id
    add_column :bookings, :candidate_motivation, :text
  end
end
