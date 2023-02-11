class RecruitersController < ApplicationController

  def index
    if params[:campaign_id]
      @recruiters = CampaignRecruiter.where(campaign_id: params[:campaign_id])
    else

    end
  end
end
