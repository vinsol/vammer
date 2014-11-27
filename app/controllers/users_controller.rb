class UsersController < ApplicationController

  before_action :fetch_user, except: [:index, :mentioned, :mentioned_users]

  before_action :allow_modify, only: [:update, :edit]

  before_action :fetch_mentioned_user, only: :mentioned_users

  ALLOWED_PARAMS = %i(name date_of_birth mobile about_me job_title
                      admin joining_date enabled) +
                      [ image_attributes: %i(attachment id) ]

  def index
    #FIXME_AB: Why not enabled is a scope
    respond_to do |format|
      format.html do
        @user = current_user
        @users = current_user.admin? ? User.all : User.where(enabled: true)
        @users = filtered_users
        # Eliminated
        # sort_order
        # sort_column
        # FIXME_AB: any column from params can be used for sorting.
        # @users = @users.order( params[:column] => params[:direction].to_sym).page params[:page]
      end
      format.json do
        data = { users: User.where('name ilike ? ', '%' + params[:term] + '%').map { |u| [u, u.image ? u.image.attachment.url(:logo) : false] },
                groups: Group.where('name ilike ? ', '%' + params[:term] + '%').map { |u| [u, false] }
               }
        render json: data
      end
    end

  end

  def follower
    @users = @user.followers
    render 'index'
  end

  def following
    @users = @user.followed_users
    render 'index'
  end

  def mentioned_users
    initialize_posts_comments
    render 'show'
  end

  def mentioned
    respond_to do |format|
      format.json do
        data = { users: User.where('name ilike ? ', '%' + params.require(:term) + '%').pluck(:name) }
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
      @user = User.where(name: params[:name].split('@').last).first
      unless @user
        flash[:error] = t('record.failure', scope: :flash)
        redirect_to :users
      end
    end

    def filtered_users
      if /[a-z]/i.match params[:letter]
        @users.where('name ilike ?', params[:letter][0] + '%').order(name: :asc)
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

end
