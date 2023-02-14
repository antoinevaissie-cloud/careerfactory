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


  def edit
  end

  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.users_id = current_user

    if @campaign.save
      # redirect to a success page or display a success message
      redirect_to @campaign, notice: 'Campaign was successfully created.'
    else
      # render the form again with error messages
      render :new
    end
  end

  private

  def campaign_params
    params.require(:campaign).permit(:batch_number, :start_date, :end_date, :slot_size, :users_id)
  end


end
