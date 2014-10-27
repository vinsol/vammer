class UsersController < ApplicationController

  before_action :authenticate_user_admin, only: [:update, :edit]

  def index
    if params[:direction]
      @users = User.order( params[:order] => params[:direction].to_sym).page params[:page]
    else
      @users = User.order(name: :asc).page params[:page]
    end
  end

  def edit
    @user = User.find(params[:id])
    unless @user.attachment
      @user.build_attachment
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(allowes_params)
      redirect_to :users
    else
      render :edit
    end
  end

  def show
    #FIX: Move it to a before_action and redirect with flash message when user not found.
    #FIX: Use #where
    @user = User.find(params[:id])
  end

  private

    def allowes_params
      params[:user].permit!
    end

    def authenticate_user_admin
      user = User.find(params[:id])
      redirect_to :users unless current_user.admin or user == current_user
    end

end
