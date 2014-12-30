class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :configure_devise_params, if: :devise_controller?
  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit( :firstname, :lastname, :email, :password, :password_confirmation, :status, :phone, :picture)
    end
  end
   protect_from_forgery with: :exception
end
