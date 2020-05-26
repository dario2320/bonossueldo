class ApplicationController < ActionController::Base
  #layout 'dashboard'
  protect_from_forgery with: :exception
  
    before_filter :configure_permitted_parameters, if: :devise_controller?
   

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :name, :email, :password, :password_confirmation, :nombre, :apellido, :dni)}
            devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:login, :password)}
            devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :nombre, :apellido) }
        end

        
        
end
