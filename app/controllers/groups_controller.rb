class GroupsController < ApplicationController

  def index
    @groups = current_user.groups
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

  private

    def permitted_params
      params[:group].permit(:name, :description)
    end

end