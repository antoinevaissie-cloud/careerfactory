class CampaignsController < ApplicationController



  def index
    @campaigns = Campaign.all
  end

  def new
    redirect_to new_choose_batch_path
  end

  def choose_batch

  end

  def choose_recruiters
    @recruiters = User.where(role: "Recruiter")
  end

  def choose_times
    @start_times = (Time.new(2023, 3, 20, 9, 0, 0)..Time.new(2023, 3, 24, 18, 0, 0)).step(1.hour)
  end



  # def new
  #   @recruiters = User.where(role: "Recruiter")
  #   @campaign = Campaign.new
  #   @start_dates = []
  #   @end_dates = []
  #   start_time = Time.new(2023, 3, 20, 9, 0, 0)
  #   end_time = Time.new(2023, 3, 24, 18, 0, 0)
  #   while start_time <= end_time
  #     @start_dates << start_time
  #     @end_dates << start_time + 1.hour
  #     start_time += 1.hour
  #   end
  # end

  def show
    @campaign = Campaign.find(params[:id])
    @students = User.where(role: 'Student', batch_number: @campaign.batch_number)
    @recruiters = @campaign.users.where(role: 'Recruiter')
    @current_campaign_recruiters = current_campaign_recruiters
  end


  def current_campaign_recruiters
    current_campaign = Campaign.find(params[:id])
    current_campaign.users.where(role: 'Recruiter')
  end


  def edit
  end



  def create
    @campaign = Campaign.new(campaign_params)
    @user = current_user
    @campaign.user_id = @user.id
    puts "User IDs: #{params[:campaign][:user_ids]}"
    raise
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
