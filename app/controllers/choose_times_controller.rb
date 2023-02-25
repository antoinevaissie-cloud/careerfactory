class ChooseTimesController < ApplicationController

  def new
    @time = ChooseTime.new
    @start_times = (Time.new(2023, 3, 20, 9, 0, 0)..Time.new(2023, 3, 24, 18, 0, 0)).step(1.hour)
    @end_times = (Time.new(2023, 3, 20, 9, 0, 0)..Time.new(2023, 3, 24, 18, 0, 0)).step(1.hour)

  end

  def create
    @time = ChooseTime.new(time_params)

    if @time.valid?
      session[:campaign][:start_date] = @time.start_date
      session[:campaign][:end_date] = @time.end_date
      session[:campaign][:slot_size] = @time.slot_size

      @campaign = Campaign.new(session[:campaign])
      @campaign.user_id = current_user.id
      if @campaign.save
        session[:campaign]["user_ids"].each do |t|
          next if t == ""
          @campaign_user = CampaignUser.new(
            campaign_id: @campaign.id,
            user_id: (t.to_i)
          )
          if @campaign_user.valid?
            @campaign_user.save
          end
        end
        redirect_to campaigns_path
      end
    else
      render :new
    end
  end


  def time_params
    params.require(:choose_time).permit(:start_date, :end_date, :slot_size)
  end
end
