class StudentsController < ApplicationController
  def index

    if params[:campaign_id]
      @campaign = Campaign.find(params[:campaign_id])

      @students = User.where(role: 'Student', batch_number: @campaign.batch_number)
    else
      @students = User.where(role: "Student")
    end
  end


end
