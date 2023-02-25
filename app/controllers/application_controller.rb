class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def after_sign_in_path_for(resource)
    if resource.role == 'Manager'
      home_path
    elsif resource.role == 'Recruiter'
      students_path
    elsif resource.role == 'Student'
      recruiters_path
    else
      super
    end
  end
end
