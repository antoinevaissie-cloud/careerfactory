class ChooseTimesController < ApplicationController

  def new
    @time = ChooseTime.new
    @start_times = (Time.new(2023, 3, 20, 9, 0, 0)..Time.new(2023, 3, 24, 18, 0, 0)).step(1.hour)
    @end_times = (Time.new(2023, 3, 20, 9, 0, 0)..Time.new(2023, 3, 24, 18, 0, 0)).step(1.hour)
  end

  def create
    @time = ChooseTime.new(time_params)

    if @time.valid?
      @campaign = Campaign.new(session[:campaign].merge(campaign_params))
      @campaign.user_id = current_user.id
      # clear session if campaign save

      if @campaign.save
        Campaign.where(batch_number: @campaign.batch_number).to_a.reject { |e| e == @campaign }.each(&:destroy)
        User.where(role: 'student', batch_number: @campaign.batch_number).find_each do |student|
          CampaignUser.create(
            campaign: @campaign,
            user: student
          )
        end
        redirect_to campaign_path(@campaign)
      end
    else
      render :new
    end
  end


  def time_params
    params.require(:choose_time).permit(:start_date, :end_date, :slot_size)
  end

  def campaign_params
    {start_date: @time.start_date, end_date: @time.end_date, slot_size: @time.slot_size}
  end
end
