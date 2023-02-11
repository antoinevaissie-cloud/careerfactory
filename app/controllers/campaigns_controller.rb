class CampaignsController < ApplicationController
  def index
  end

  def new
    @recruiters = User.where(role: "Recruiter")
  end

  def create
  end

  def edit
  end

end
