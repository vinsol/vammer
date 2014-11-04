class GroupsController < ApplicationController

  before_action :authenticate_user_admin, only: [:edit, :update]
  before_action :fetch_group, only: [:join, :unjoin, :update, :edit, :show, :members]
  before_action :initialize_posts, only: [:show]

  include Sort

  def index
    @groups = current_user.groups
    @groups = collection(@groups)
  end

  #FIX: Rename to some better name
  def other
    @groups = Group.search_other(current_user)
    @groups = collection(@groups)
    render :index
  end

  def owned
    @groups = current_user.created_groups
    @groups = collection(@groups)
    render :index
  end

  def new
    @group = Group.new
  end

  def create
    #FIX: Use #owned_groups association for creation
    group = current_user.groups.create(permitted_params)
    group.user_id = current_user.id
    #FIX: Flash messages
    if group.save
      #FIX: Use common syntax for path
      redirect_to groups_path
    else
      #FIX: Use common syntax for path
      redirect_to new_group_path
    end
  end

  def unjoin
    if @group.creator != current_user
      @group.users.destroy(current_user)
    #FIX: Move else logic to before action
    else
      flash[:notice] = t('.failure', scope: :flash)
    end
    redirect_to groups_path
  end

  def join
    #FIX: Add a before_action to return if user is already present in group
    #FIX: Handle success/failure
    #FIX: Add flash
    @group.users.push(current_user)
    redirect_to groups_path
  end

  def edit
  end

  def update
    @group.update(permitted_params)
    redirect_to groups_path
  end

  def show
    group = Group.where(id: params[:id]).first
    #FIX: What is group is not found. Handle it in before_action
    @posts = group.posts
  end

  def members
    @members = @group.users.page params[:page]
  end

  private

    def authenticate_user_admin
      unless current_user.admin? or @user == current_user
        flash[:notice] = t('access.failure', scope: :flash)
        redirect_to :users
      end
    end

    def permitted_params
      params[:group].permit(:name, :description)
    end

    def fetch_group
      @group = Group.where(id: params[:id]).first
      unless @group
        flash[:notice] = t('record.failure', scope: :flash)
        redirect_to groups_path
      end
    end

    #FIX: We are not initializing posts here. only one post.
    #FIX: Add different methods for initialization and loading existing posts
    #FIX: Also this should not be a before_action
    def initialize_posts
      @post = Post.new
      @post.build_document
      @posts = Post.where(user_id: current_user)
    end

end
