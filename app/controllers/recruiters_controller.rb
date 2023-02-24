class RecruitersController < ApplicationController

  def index
    if params[:campaign_id]
      @recruiters = Campaign.find(params[:campaign_id]).users

      @slot_size_in_min = "#{Campaign.find(params[:campaign_id]).slot_size}min"

    else
      @recruiters = User.where(role: "Recruiter")
    end
  end
end
