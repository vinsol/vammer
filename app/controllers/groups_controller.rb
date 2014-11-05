class GroupsController < ApplicationController

  before_action :authenticate_user_admin, only: [:edit, :update]
  before_action :fetch_group, only: [:join, :unjoin, :update, :edit, :show, :members]
  before_action :fetch_groups
  before_action :creator_logged_in?, only: :unjoin

  def sort(collection)
    sort_order
    sort_column
    if params[:column] == 'creator'
      collection.joins(:creator).order("users.name #{params[:direction]}").page params[:page]
    else
      collection.order( params[:column] => params[:direction].to_sym).page params[:page]
    end
  end

  def index
    @groups = current_user.groups
    @groups = sort(@groups)
  end

  #FIX: Rename to some better name
  def extraneous
    @groups = Group.search_other(current_user)
    @groups = sort(@groups)
  end

  def owned
    @groups = current_user.owned_groups
    @groups = sort(@groups)
  end

  def new
    @group = Group.new
  end

  def create
    #FIX: Use #owned_groups association for creation -DONE
    group = current_user.owned_groups.create(permitted_params)
    group.members.push current_user
    #FIX: Flash messages
    if group.save
      #FIX: Use common syntax for path -DONE
      redirect_to :groups
    else
      #FIX: Use common syntax for path -DONE
      redirect_to :new_group
    end
  end

  def unjoin
    @group.members.destroy(current_user)
    #FIX: Move else logic to before action -DONE
  end

  def join
    #FIX: Add a before_action to return if user is already present in group -DONE
    #FIX: Handle success/failure
    #FIX: Add flash
    @group.members.push(current_user)
    redirect_to :groups
  end

  def edit
  end

  def update
    @group.update(permitted_params)
    redirect_to :groups
  end

  def show
    initialize_posts
    fetch_posts
    #FIX: What is group is not found. Handle it in before_action -DONE
    @posts = @group.posts
  end

  def members
    initialize_posts
    @members = @group.members.page params[:page]
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
        redirect_to :groups
      end
    end

    #FIX: We are not initializing posts here. only one post. -DONE
    #FIX: Add different methods for initialization and loading existing posts -DONE
    #FIX: Also this should not be a before_action -DONE
    def initialize_posts
      @post = Post.new
      @post.build_document
    end

    def fetch_posts
      @posts = Post.where(user_id: current_user)
    end

    def creator_logged_in?
      if @group.creator == current_user
        flash[:notice] = t('.failure', scope: :flash)
        redirect_to :groups      
      end
    end

end
