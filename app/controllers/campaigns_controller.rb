class CampaignsController < ApplicationController
  def index
  end

  def new
    @recruiters = User.where(role: "Recruiter")
    @campaign = Campaign.new
  end

  def create
  end

  def edit
  end

end
