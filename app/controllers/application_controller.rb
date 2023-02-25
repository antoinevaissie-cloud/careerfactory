class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?




  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role])
  end

  def after_sign_in_path_for(resource)
 #   raise
    if resource.role == 'Manager'
      root_path
    elsif resource.role == 'Recruiter'
      root_path
    elsif resource.role == 'Student'
      root_path
    else
      super
    end
  end
end
