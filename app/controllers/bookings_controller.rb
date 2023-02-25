class BookingsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:handle_cal_webhook]
  skip_before_action :authenticate_user!, only: [:handle_cal_webhook]

  def new
    @campaign = Campaign.find(params[:campaign_id])
    @recruiter = User.find(params[:recruiter_id])
  end

  def create
  end

  def handle_cal_webhook
    recruiter_email = params.dig('payload', 'organizer', 'email')
    recruiter = User.find_by(email: recruiter_email)
    candidate_email = params.dig('payload', 'attendees').first.dig('email')
    candidate = User.find_by(email: attendee_email)
    calendly_booking_id = params.dig('payload', 'uid')
    start_time = DateTime.parse(params.dig('payload', 'startTime'))
    end_time = DateTime.parse(params.dig('payload', 'endTime'))

    Booking.create(
      recruiter: recruiter,
      candidate: candidate,
      start_time: start_time,
      end_time: end_time,
      candidate_motivation: params.dig('payload', 'description'),
      calendly_booking_id: calendly_booking_id,
      campaign: candidate.batch_campaign
    )
  end

  def list_bookings
    if current_user.cal_api_key.present?
      @api_key = current_user.cal_api_key
    else
      @api_key = current_user.role == 'Student' ? ENV['STUDENT_API_KEY'] : ENV['RECRUITER_API_KEY']
    end
  end
end
