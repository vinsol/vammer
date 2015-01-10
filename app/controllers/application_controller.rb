class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_devise_params, if: :devise_controller?
  before_action :authenticate_user!, :fetch_logo
  prepend_before_action :session_valid?, unless: :devise_controller?

  private

    def session_valid?
      unless verified_request?
        respond_to do |format|
          format.html {  }
          format.js { render :js => "window.location = '/users/sign_in'" }
        end
      end
    end

    #FIX: Make a HomeController and move this action there -DONE
    #FIX: Rename to #fetch_user_groups DONE
    def fetch_user_groups
      #FIX: if condition not required -DONE
      @user_groups = current_user.groups
    end

    #FIX: This comment is not associated to any post. Add a post_id field in the form where it is being used. -DONE
    def initialize_comment
      @comment = Comment.new
      @comment.comment_documents.build
    end

    def initialize_post
      @post = Post.new
      @post.post_documents.build
    end

    def fetch_posts
      #FIX: All inludes can be written as a collection e.g. includes(:user, :documents, :comments) -DONE
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
      #FIXME_AB: Do we have a better way? DONE
      #FIX: Do not change params. You may use instance variable or directly return string from the method DONE
      params[:direction] == 'asc' ? 'asc' : 'desc'
    end

    def sort_column
      #FIXME_AB: Can you identify potential issue? DONE
      params[:column].blank? ? 'created_at' : params[:column]
    end

    def fetch_logo
      @logo = Setting.first || Setting.create
      @logo.build_image unless @logo.image
    end

end
