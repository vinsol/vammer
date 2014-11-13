class GroupsController < ApplicationController

  before_action :fetch_group, only: [:join, :unjoin, :update, :edit, :show, :members]
  before_action :fetch_user_groups
  #FIX: Remove this. Already called in action -DONE
  before_action :allow_modify, only: [:edit, :update]
  before_action :allow_unjoin, only: :unjoin
  before_action :allow_join, only: :join

  def sort(collection)
    sort_order
    sort_column
    if params[:column] == 'creator'
      Group.sort_by_creator(collection, params[:direction]).page params[:page]
    else
      Group.sort(collection, params[:column], params[:direction].to_sym).page params[:page]
    end
  end

  def index
    @groups = current_user.groups
    @groups = sort(@groups)
  end

  def extraneous
    @groups = current_user.search_extraneous
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
    group = current_user.owned_groups.create(permitted_params)
    if group.save
      #FIX: Flash message for success -DONE
      flash[:notice] = t('.success', scope: :flash)
      redirect_to :groups
    else
      flash[:error] = t('.failure', scope: :flash)
      redirect_to :new_group
    end
  end

  def unjoin
    if @group.members.destroy(current_user)
      flash[:notice] = t('.success', scope: :flash)
    else
      flash[:error] = t('.failure', scope: :flash)
    end
    redirect_to :groups
  end

  def join
    #FIX: Add flash -DONE
    if @group.members.push(current_user)
      flash[:notice] = t('.success', scope: :flash)
    else
      flash[:error] = t('.failure', scope: :flash)
    end
    redirect_to :groups
  end

  def edit
  end

  def update
    if @group.update(permitted_params)
      flash[:notice] = t('.success', scope: :flash)
      redirect_to :groups
    else
      flash[:error] = t('.failure', scope: :flash)
      render :edit
    end
  end

  def show
    initialize_post
    @posts = @group.posts.order(created_at: :desc)
  end

  def members
    initialize_post
    @members = @group.members.page params[:page]
  end

  private

    #FIX: Rename to #allow_modify -DONE
    def allow_modify
      #FIX: Use '||' instead of 'or' -DONE
      unless current_user.admin? || @group.creator == current_user
        flash[:error] = t('access.failure', scope: :flash)
        redirect_to :groups
      end
    end

    def permitted_params
      params.require(:group).permit(:name, :description)
    end

    def fetch_group
      @group = Group.where(id: params[:id]).first
      unless @group
        flash[:error] = t('record.failure', scope: :flash)
        redirect_to :groups
      end
    end

    #FIX: Rename to #initialize_post -DONE
    def initialize_post
      @post = Post.new
      @post.build_document
    end

    def allow_unjoin
      #FIX: Use '||'
      if @group.creator == current_user || !(@group.members.include? current_user)
        flash[:error] = t('.failure', scope: :flash)
        redirect_to :groups
      end
    end

    #FIX: We do need a method for this. -DONE
    def allow_join
      if @group.members.include? current_user
        flash[:error] = t('.failure', scope: :flash)
        redirect_to :groups
      end
    end

end
