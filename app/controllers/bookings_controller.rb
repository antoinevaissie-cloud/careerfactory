class BookingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @campaign = Campaign.find(params[:campaign_id])
    @recruiter = User.find(params[:recruiter_id])

  end

  def create


  end


end
