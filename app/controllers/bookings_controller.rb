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

  def convert_to_utc_plus_one(datetime)
    datetime.in_time_zone('UTC+1').strftime('%Y-%m-%d %H:%M:%S')
  end

  def handle_cal_webhook
    recruiter_email = params.dig('payload', 'organizer', 'email')
    recruiter = User.find_by(email: recruiter_email)
    candidate_email = params.dig('payload', 'attendees').first.dig('email')
    candidate = User.find_by(email: candidate_email)
    calendly_booking_id = params.dig('payload', 'uid')
    start_time = DateTime.parse(params.dig('payload', 'startTime'))
    end_time = DateTime.parse(params.dig('payload', 'endTime'))

    # {"type"=>"30 Min Meeting",
    #   "title"=>"30 Min Meeting between Careers Factory and Antoine Vaissié",
    #   "description"=>"I'm interested in working for youuuu",
    #   "additionalNotes"=>"I'm interested in working for youuuu",
    #   "customInputs"=>{},
    #   "startTime"=>"2023-03-07T08:00:00Z",
    #   "endTime"=>"2023-03-07T08:30:00Z",
    #   "organizer"=>{"id"=>65078, "name"=>"Careers Factory", "email"=>"email-b@factory.careers", "timeZone"=>"Europe/Paris", "language"=>{"locale"=>"en"}},
    #   "attendees"=>[{"email"=>"armellebonnin@lewagon.org", "name"=>"Antoine Vaissié", "timeZone"=>"Europe/Paris", "language"=>{"locale"=>"en"}}],
    #   "location"=>"integrations:daily",
    #   "destinationCalendar"=>{"id"=>54613, "integration"=>"google_calendar", "externalId"=>"email-b@factory.careers", "userId"=>65078, "eventTypeId"=>nil, "credentialId"=>79346},
    #   "hideCalendarNotes"=>false,
    #   "requiresConfirmation"=>nil,
    #   "eventTypeId"=>223478,
    #   "seatsShowAttendees"=>false,
    #   "seatsPerTimeSlot"=>nil,
    #   "uid"=>"45ZSTFk9np2RhDCLogUjq6",
    #   "conferenceData"=>{"createRequest"=>{"requestId"=>"2db644eb-37a5-581a-99fa-ebe6ce513834"}},
    #   "videoCallData"=>{"type"=>"daily_video", "id"=>"iwZhS6d897FhTUYtQ76B", "password"=>"[FILTERED]", "url"=>"https://meetco.daily.co/iwZhS6d897FhTUYtQ76B"},
    #   "appsStatus"=>
    #    [{"appName"=>"Cal Video", "type"=>"daily_video", "success"=>1, "failures"=>0, "errors"=>[]}, {"appName"=>"Google Calendar", "type"=>"google_calendar", "success"=>1, "failures"=>0, "errors"=>[], "warnings"=>[]}],
    #   "eventTitle"=>"30 Min Meeting",
    #   "eventDescription"=>nil,
    #   "price"=>0,
    #   "currency"=>"usd",
    #   "length"=>30,
    #   "bookingId"=>250688,
    #   "metadata"=>{"videoCallUrl"=>"https://app.cal.com/video/45ZSTFk9np2RhDCLogUjq6"},
    #   "status"=>"ACCEPTED"}


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

  def index
    @bookings = current_user.bookings
    @bookings.each do |booking|
      booking.start_time = booking.start_time.in_time_zone("Europe/Paris").strftime("%Y-%m-%d %H:%M:%S")
      booking.end_time = booking.end_time.in_time_zone("Europe/Paris").strftime("%Y-%m-%d %H:%M:%S")
    end
  end

end
