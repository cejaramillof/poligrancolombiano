class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  #check if user is admin
  def authenticate_admin!
    unless current_user.present? && current_user.admin?
      flash[:error] = "No tienes permisos."
      redirect_to root_path
    end
  end


  def outdated_user
    if current_user.created_at <= 1.year.ago
        current_user.update!(approved: false)
    end
  end

  #permitir parametros
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :birth_date, :height, :sex, :name, meals_attributes: Meal.attribute_names.map(&:to_sym).push(:_destroy)) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :password_confirmation, :birth_date, :height, :sex, :name, meals_attributes: Meal.attribute_names.map(&:to_sym).push(:_destroy)) }
  end
end
