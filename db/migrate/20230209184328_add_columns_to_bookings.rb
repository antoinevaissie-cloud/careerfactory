class AddColumnsToBookings < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :campaign, foreign_key: true
    add_reference :bookings, :recruiter, foreign_key: { to_table: :users }
    add_reference :bookings, :candidate, foreign_key: { to_table: :users }
  end
end
