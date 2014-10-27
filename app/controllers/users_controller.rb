class UsersController < ApplicationController

  before_action :find_selected_user
  before_action :authenticate_user_admin, only: [:update, :edit]

  def index
    if params[:direction]
      @users = User.order( params[:order] => params[:direction].to_sym).page params[:page]
    else
      @users = User.order(name: :asc).page params[:page]
    end
  end

  def edit
    unless @user.attachment
      @user.build_attachment
    end
  end

  def update
    if @user.update(permitted_params)
      redirect_to :users
    else
      render :edit
    end
  end

  private

    def permitted_params
      params[:user].permit!
    end

    def authenticate_user_admin
      user = User.find(params[:id])
      redirect_to :users unless current_user.admin or user == current_user
    end

    def find_selected_user
      @user = User.where(id: params[:id]).first
    end

end
