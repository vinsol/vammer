class UsersController < ApplicationController

  before_action :authenticate_user_admin, only: [:update, :edit]

  def index
    @users = current_user.admin ? User.all : User.where(enabled: true)

    if params[:direction]
      @users = @users.order( params[:order] => params[:direction].to_sym).page params[:page]
    else
      @users = @users.order(name: :asc).page params[:page]
    end

  end

  def edit
    #FIX: Use already loaded resource in before_action
    @user = User.find(params[:id])
    #FIX: In one line
    unless @user.attachment
      @user.build_attachment
    end
  end

  def update
    #FIX: Use already loaded resource in before_action
    @user = User.find(params[:id])
    #FIX: Add flash messages
    if @user.update(allowes_params)
      redirect_to :users
    else
      render :edit
    end
  end

  private

    #FIX: Rename to #permitted_params
    def allowes_params
      #FIX: Make a constant to store all the permitted attributes
      params.require(:user).permit(:name, :date_of_birth, :mobile, :about_me, :job_title, :admin, :joining_date, :enabled, attachment_attributes: [:attachment_cache, :id, :attachment])
    end

    #FIX: Use #where to fetch resources instead of #find
    def authenticate_user_admin
      user = User.find(params[:id])
      #FIX: Display a flash message in case of redirect below
      redirect_to :users unless current_user.admin or user == current_user
    end

end
