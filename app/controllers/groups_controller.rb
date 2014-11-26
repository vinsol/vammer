class GroupsController < ApplicationController

  before_action :fetch_group, only: [:join, :unjoin, :update, :edit, :show, :members]
  before_action :fetch_user_groups
  before_action :allow_modify, only: [:edit, :update]
  before_action :allow_unjoin, only: :unjoin
  before_action :allow_join, only: :join
  before_action :sorting_valid?, only: [:join, :extraneous, :owned]

  def index
    @groups = current_user.groups.includes(:creator)
    @groups = sort(@groups)
  end

  def extraneous
    @groups = current_user.search_extraneous.includes(:creator)
    @groups = sort(@groups)
  end

  def owned
    @groups = current_user.owned_groups.includes(:creator)
    @groups = sort(@groups)
  end

  def new
    @group = Group.new
  end

  def create
    group = current_user.owned_groups.create(permitted_params)
    if group.save
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
    initialize_comment
    @posts = @group.posts.order(created_at: :desc).includes(:user, :documents, :comments)
  end

  def members
    initialize_post
    @members = @group.members.page params[:page]
  end

  private

    def allow_modify
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

    def allow_unjoin
      if @group.creator == current_user || @group.members.exclude?(current_user)
        flash[:error] = t('.failure', scope: :flash)
        redirect_to :groups
      end
    end

    def allow_join
      if @group.members.include? current_user
        flash[:error] = t('.failure', scope: :flash)
        redirect_to :groups
      end
    end

    def sorting_valid?
      (['desc', 'asc'].include? params[:direction] and ['name', 'creator'].include?(params[:order]))
    end

    def sort(collection)
      order = sort_order
      column = sort_column
      if params[:column] == 'creator'
        Group.sort_by_creator(collection, order).page params[:page]
      else
        Group.sort(collection, column, order.to_sym).page params[:page]
      end
    end

end
