class BookingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @campaign = Campaign.find(params[:campaign_id])
    @recruiter = User.find(params[:recruiter_id])

  end

  def create


  end

  def list_bookings
    user = User.find(current_user.id)

    @api_key = user.role == 'Student' ? ENV['STUDENT_API_KEY'] : ENV['RECRUITER_API_KEY']
  end


end
