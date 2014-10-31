class GroupsController < ApplicationController

  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
  end

  def create
    group = current_user.groups.new(permitted_params)
    group.update(user_id: current_user.id)
    redirect_to groups_path
  end

  private

    def permitted_params
      params[:group].permit(:name, :description)
    end

end