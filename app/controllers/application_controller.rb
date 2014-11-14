class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_devise_params, if: :devise_controller?
  before_action :authenticate_user!, :fetch_logo

  private

    def configure_devise_params
      devise_parameter_sanitizer.for(:sign_up) do |user|
        user.permit(:name, :email, :password, :password_confirmation)
      end
    end

    def after_sign_in_path_for(resource)
      root_path
    end

    def fetch_user_groups
      @my_groups = current_user.groups
    end

    def sort_order
      #FIXME_AB: Do we have a better way?
      #FIX: Do not change params. You may use instance variable or directly return string from the method
      params[:direction] = 'asc' unless params[:direction] == 'desc'
    end

    def sort_column
      #FIXME_AB: Can you identify potential issue?
      params[:column] = 'created_at' if params[:column].blank?
    end

    def fetch_posts
      @posts = Post.order(created_at: :desc)
    end

    def fetch_logo
      @logo = Setting.first
    end

end
