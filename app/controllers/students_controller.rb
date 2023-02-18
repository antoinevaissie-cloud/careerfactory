class StudentsController < ApplicationController
  def index
    if params[:campaign_id]
      @students = Campaign.find(params[:campaign_id]).users.where(role: "Student")
    else
      @students = User.where(role: "Student")
    end
  end
end
