class ChooseRecruitersController < ApplicationController

  def new
    @recruiter = ChooseRecruiter.new
    @recruiters = User.where(role: "recruiter")
  end

  def create
    @recruiter = ChooseRecruiter.new(recruiter_params)
    if @recruiter.valid?
      session[:campaign][:user_ids] = @recruiter.user_ids.compact_blank

      redirect_to new_choose_time_path
    else
      @recruiters = User.where(role: "recruiter")
      render :new
    end

  end

  def recruiter_params
    params.require(:choose_recruiter).permit(user_ids: [])
  end
end
