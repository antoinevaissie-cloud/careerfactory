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
    @candidates = User.where(role: 'Student', batch_number: @campaign.batch_number)
    @recruiters = @campaign.users.where(role: 'Recruiter')

  end


  def edit
  end

  def create
    @campaign = Campaign.new(campaign_params)
    @user = current_user
    @campaign.user_id = @user.id
    puts "User IDs: #{params[:campaign][:user_ids]}"

    if @campaign.save

    else
      # render the form again with error messages
      render :new
    end

    params[:campaign][:user_ids].each do |t|
       @campaign_user = CampaignUser.new(
         campaign_id: @campaign.id,
         user_id: (t.to_i)
       )
       if @campaign_user.valid?
         @campaign_user.save
        else
          puts @campaign_user.errors.full_messages
        end


    end
    redirect_to campaigns_path, notice: 'Campaign was successfully created.'


  end


  private
  def campaign_params
    params.require(:campaign).permit(:batch_number, :start_date, :end_date, :slot_size, :user_ids)
  end



end
