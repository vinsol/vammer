class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_devise_params, if: :devise_controller?
  before_action :authenticate_user!, :fetch_logo
  prepend_before_action :user_active?, unless: :devise_controller?

  private

    def user_active?
      unless user_signed_in?
        respond_to do |format|
          format.html {  }
          format.js { render :js => "window.location = '/users/sign_in'" }
        end
      end
    end

    def fetch_user_groups
      @user_groups = current_user.groups
    end

    def initialize_comment
      @comment = Comment.new
      @comment.comment_documents.build
    end

    def initialize_post
      @post = Post.new
      @post.post_documents.build
    end

    def fetch_posts
      @posts = Post.includes(:user, :post_documents, :comments).order(created_at: :desc)
    end

    def configure_devise_params
      devise_parameter_sanitizer.for(:sign_up) do |user|
        user.permit(:name, :email, :password, :password_confirmation)
      end
    end

    def after_sign_in_path_for(resource)
      root_path
    end

    def sort_order
      #FIXME_AB: Do we have a better way?
      params[:direction] == 'asc' ? 'asc' : 'desc'
    end

    def sort_column
      #FIXME_AB: Can you identify potential issue?
      #FIX: Override in specific controllers. Check for valid sortable columns. If params[:column] is blank or invalid, use :created_at
      params[:column].blank? ? 'created_at' : params[:column]
    end

    def fetch_logo
      @logo = Setting.first || Setting.create
      @logo.build_image unless @logo.image
    end

end
