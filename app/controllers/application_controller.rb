class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?





  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role])
  end

  def after_sign_in_path_for(resource)
 #   raise
    if resource.role == 'manager'
      root_path
    elsif resource.role == 'recruiter'
      root_path
    elsif resource.role == 'student'
      root_path
    else
      super
    end
  end
end
