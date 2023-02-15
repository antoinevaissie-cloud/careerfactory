class RecruitersController < ApplicationController

  def index
    if params[:campaign_id]
      @recruiters = Campaign.find(params[:campaign_id]).users

      #pluck(:user_id)

    else
      @recruiters = User.where(role: "Recruiter")
    end
  end
end
