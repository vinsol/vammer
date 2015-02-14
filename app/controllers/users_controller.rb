class UsersController < ApplicationController

  #FIX: Use only instead of except DONE
  before_action :fetch_user, only: [:follower, :following, :edit, :show, :update, :follow, :unfollow]

  before_action :allow_modify, only: [:update, :edit]

  before_action :fetch_mentioned_user, only: :mentioned_users

  ALLOWED_PARAMS = %i(name date_of_birth mobile about_me job_title
                      admin joining_date enabled) +
                      [ image_attributes: %i(attachment id) ]

  def index
    respond_to do |format|
      format.html do
        #FIX: Move to a method #fetch_users. Inside that call #filter_users for filtering by letter DONE
        fetch_users
      end
      format.json do
        #FIX: Make a method in User, Group for searching. DONE
        #FIX: Move json creation to a private method. DONE
        #FIX: Try to use serializer for creating this json.
        #FIX: Group has no image. so no need to check DONE
        render json: fetch_user_groups
      end
    end

  end

  def follower
    @users = @user.followers
    #FIX: Use symbol syntax for rendering DONE
    render :index
  end

  def following
    @users = @user.followed_users
    #FIX: Use symbol syntax for rendering DONE
    render :index
  end

  #FIX: See if we can change the search_mentionable user link href to /users/:id. Then we can completely remove this action.
  def mentioned_users
    initialize_posts_comments
    render :show
  end

  #FIX: Rename to #search_mentionable DONE
  def search_mentionable
    respond_to do |format|
      format.json do
        #FIX: Search users with names beginning with term only DONE
        data = { users: User.where('name ilike ? ',params[:term] + '%').map { |user| { name: user.name, image: user.image.attachment.url(:logo) } } }
        render json: data
      end
    end
  end

  def edit
    @user.build_image unless @user.image
  end

  def show
    initialize_posts_comments
  end

  def update
    if @user.update(permitted_params)
      flash[:notice] = t('.success', scope: :flash)
      redirect_to :users
    else
      flash[:error] = t('.failure', scope: :flash)
      render :edit
    end
  end

  def follow
    if @user.followers << current_user
      #FIX: Use single method for follow/unfollow success just like in post controller #like DONE
      data = { followed: true, unfollow_path: unfollow_user_path(@user) }
    else
      data = { followed: false }
    end
    respond_to do |format|
      format.json do
        render json: data
      end
    end
  end

  def unfollow
    if @user.followers.delete current_user
      #FIX: Use single method for follow/unfollow failure just like in post controller #unlike
      data = { followed: true, follow_path: follow_user_path(@user) }
    else
      data = { followed: false }
    end
    respond_to do |format|
      format.json do
        render json: data
      end
    end
  end

  private

    def initialize_posts_comments
      initialize_comment
      initialize_post
      @posts = @user.posts.order(created_at: :desc)
    end

    def permitted_params
      params.require(:user).permit *ALLOWED_PARAMS
    end

    def fetch_user
      @user = User.where(id: params[:id]).first
      unless @user
        flash[:error] = t('record.failure', scope: :flash)
        redirect_to :users
      end
    end

    def fetch_mentioned_user
      @user = User.where('name ilike ? ',params[:name].split('@').last ).first
      unless @user
        flash[:error] = t('record.failure', scope: :flash)
        redirect_to :users
      end
    end

    def filtered_users
      if /[a-z]/i.match params[:letter]
        #FIX: See if we can write this as #where('name ilike ?%', params[:letter][0]) DONE
        #FIX: We don't need to take first letter from params[:letter]. Assume we will receive a single letter in params. DONE
        @users.where('name ilike ?', params[:letter] + '%').order(name: :asc)
      else
        @users
      end
    end

    def allow_modify
      unless current_user.admin? || @user == current_user
        flash[:error] = t('access.failure', scope: :flash)
        redirect_to :users
      end
    end

    def fetch_users
      @user = current_user
      @users = current_user.admin? ? User.all : User.enabled
      @users = filtered_users
    end

    def fetch_user_groups
     { users: User.fetch_users(params[:term]),
       groups: Group.fetch_groups(params[:term]) }
    end

end
