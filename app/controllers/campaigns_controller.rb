class CampaignsController < ApplicationController
  def index
  end

  def new
    @recruiters = User.where(role: "Recruiter")
    @campaign = Campaign.new
    @start_dates = []
    @end_dates = []

    start_time = Time.new(2023, 3, 20, 9, 0, 0)
    end_time = Time.new(2023, 3, 24, 18, 0, 0)

    while start_time <= end_time
      @start_dates << start_time
      @end_dates << start_time + 1.hour

      start_time += 1.hour
    end
  end

  def create
    raise
  end

  def edit
  end

end
