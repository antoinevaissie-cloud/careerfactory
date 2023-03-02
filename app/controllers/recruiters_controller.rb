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
    @company_key = @recruiter.company.photo.key
    @avatar_key = @recruiter.avatar.key
    @company = @recruiter.company
    @looking_for = @recruiter.looking_for
    skills_string = @recruiter.skills
    @skills_array = skills_string.split(", ")
    @company_descriptions = @recruiter.company.company_descriptions
  end
end
