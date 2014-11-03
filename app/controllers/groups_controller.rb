class GroupsController < ApplicationController

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
    group.user_id = current_user.id
    if group.save
      redirect_to groups_path
    else
      redirect_to new_group_path
    end
  end

  def unjoin
    group = Group.where(id: params[:id]).first
    if group.creator != current_user
      group.users.destroy(current_user)
    else
      flash[:notice] = t('.failure', scope: :flash)
    end
    redirect_to groups_path
  end

  def join
    group = Group.where(id: params[:id]).first
    group.users.push(current_user)
    redirect_to groups_path
  end

  def edit
  end

  private

    def permitted_params
      params[:group].permit(:name, :description)
    end

end