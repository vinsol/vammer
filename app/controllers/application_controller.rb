class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :fetch_logo

  def after_sign_in_path_for(resource)
    root_path
  end

  def fetch_logo
    @setting = Setting.where(key: :logo).first
  end

end
