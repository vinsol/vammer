class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_devise_params, if: :devise_controller?
  before_action :authenticate_user!, :fetch_logo

  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) do |user|
      user.permit(:name, :email, :password, :password_confirmation)
    end
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  private

    def fetch_logo
      @logo = Setting.first
    end

  #FIX: Make a HomeController and move this action there -DONE
  #FIX: Rename to #fetch_user_groups
    def fetch_user_groups
      #FIX: if condition not required -DONE
      @user_groups = current_user.groups
    end

    def sort_order
      params[:direction] = 'asc' unless params[:direction] == 'desc'
    end

    def sort_column
      params[:column] = 'created_at' if params[:column].blank?
    end

    #FIX: This comment is not associated to any post. Add a post_id field in the form where it is being used.
    def initialize_comment
      @comment = Comment.new
      @comment.document_files.build
    end

    def initialize_post
      @post = Post.new
      @post.documents.build
    end

    def fetch_posts
      #FIX: All inludes can be written as a collection e.g. includes(:user, :documents, :comments)
      @posts = Post.includes(:user).includes(:documents).includes(:comments).order(created_at: :desc)
    end

end
