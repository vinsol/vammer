class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_devise_params, if: :devise_controller?
  #FIX: Call :fetch_groups in specific controllers -DONE
  before_action :authenticate_user!, :fetch_logo


  def fetch_logo
    @logo = Setting.where(key: :logo).first
  end

  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) do |user|
      user.permit(:name, :email, :password, :password_confirmation)
    end
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def fetch_groups
    if current_user
      @my_groups = current_user.groups
    end
  end

  #FIX: Make a HomeController and move this action there -DONE

  def sort_order
    params[:direction] = 'asc' unless params[:direction] == 'desc'
  end

  def sort_column
    params[:column] = 'created_at' if params[:column].blank?
  end

end
