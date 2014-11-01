class GroupsController < ApplicationController

  before_action :fetch_group, on: [:join, :unjoin, :update, :edit]

  include Sort

  def index
    @groups = current_user.groups
    @groups = collection(@groups)
  end

  def other
    @groups = Group.search_other(current_user).page params[:page]
    @groups = collection(@groups)
    render :index
  end

  def owned
    @groups = current_user.created_groups.page params[:page]
    @groups = collection(@groups)
    render :index
  end

  def new
    @group = Group.new
  end

  def create
    group = current_user.groups.create(permitted_params)
    group.update(user_id: current_user.id)
    redirect_to groups_path
  end

  def unjoin
    if @group.creator != current_user
      @group.users.destroy(current_user)
    else
      flash[:notice] = t('.failure', scope: :flash)
    end
    redirect_to groups_path
  end

  def join
    @group.users.push(current_user)
    redirect_to groups_path
  end

  def edit
  end

  def update
    @group.update(permitted_params)
    redirect_to groups_path
  end

  private

    def permitted_params
      params[:group].permit(:name, :description)
    end

    def fetch_group
      @group = Group.where(id: params[:id]).first
    end

end