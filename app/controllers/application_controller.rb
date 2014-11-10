class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_devise_params, if: :devise_controller?
  before_action :authenticate_user!, :fetch_logo


  def fetch_logo
    @logo = Setting.first
  end

  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) do |user|
      user.permit(:name, :email, :password, :password_confirmation)
    end
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  #FIX: Rename to #fetch_user_groups
  def fetch_groups
    #FIX: if condition not required
    if current_user
      @my_groups = current_user.groups
    end
  end

  def sort_order
    params[:direction] = 'asc' unless params[:direction] == 'desc'
  end

  def sort_column
    params[:column] = 'created_at' if params[:column].blank?
  end

end
