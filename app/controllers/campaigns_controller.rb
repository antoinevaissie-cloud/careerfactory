class CampaignsController < ApplicationController
  def index
    @campaigns = Campaign.all
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

  def show
    @campaign = Campaign.find(params[:id])

    # Get the list of candidate and recruiter users
    @candidates = @campaign.user.where(role: 'candidate')
    @recruiters = @campaign.user.where(role: 'recruiter')

  end


  def edit
  end

  def create
    @campaign = Campaign.new(campaign_params)
    @user = current_user
    @campaign.user_id = @user.id
    campaigns_params[:user_ids].each do |t|
      @campaign_users = CampaignUser.
    raise
    # @campaign_users = CampaignUsers.new
    #   CampaignUser.create(
    #     campaign_id: @campaign.id,
    #     user_id: CampaignUser.where(role: "recruiter")
    #   )
  # end


    if @campaign.save
      # redirect to a success page or display a success message
      redirect_to campaigns_path, notice: 'Campaign was successfully created.'
    else
      # render the form again with error messages
      render :new
    end
  end

  private

  def campaign_params
    params.require(:campaign).permit(:batch_number, :start_date, :end_date, :slot_size, :user_ids)
  end



end
