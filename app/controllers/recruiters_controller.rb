class RecruitersController < ApplicationController

  def index
    if params[:campaign_id]
      current_campaign = Campaign.find(params[:campaign_id])
      @recruiters = current_campaign.users

      @slot_size_in_min = "#{current_campaign.slot_size}min"
    else
      @recruiters = User.where(role: "Recruiter")
    end
  end

  def show
    @recruiter = User.find(params[:id])
  end
end
