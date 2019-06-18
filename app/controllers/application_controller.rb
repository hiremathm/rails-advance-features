class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?
  	
	helper_method :user_name
  	protected

  	def configure_permitted_parameters
    	devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name])
  	end

  	def user_name
  	 	current_user.name
  	end

end
