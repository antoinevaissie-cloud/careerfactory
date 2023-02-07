class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.text :recruiter_feedback
      t.text :candidate_feedback
      t.integer :calendly_booking_id

      t.timestamps
    end
  end
end
