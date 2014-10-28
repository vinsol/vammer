class UsersController < ApplicationController

  before_action :fetch_user, except: [:index]

  before_action :authenticate_user_admin, only: [:update, :edit]

  ALLOWED_PARAMS = %i(name date_of_birth mobile about_me job_title
                      admin joining_date enabled) +
                      [ attachment_attributes: %i(id attachment) ]

  def index

    @users = current_user.admin ? User.all : User.where(enabled: true)
    if params[:direction]
      if sorting_valid?
        @users = @users.order( params[:order] => params[:direction].to_sym).page params[:page]
      else
        redirect_to users_path
      end
    else
      @users = @users.order(name: :asc).page params[:page]
    end

  end

  def edit
    @user.build_attachment unless @user.attachment
  end

  def update
    if @user.update(permitted_params)
      flash[:notice] = 'user updated successfully'
      redirect_to :users
    else
      flash[:notice] = 'user not updated'
      render :edit
    end
  end

  private

    def permitted_params
      params.require(:user).permit *ALLOWED_PARAMS
    end

    def fetch_user
      @user = User.where(id: params[:id]).first
      unless @user
        flash[:notice] = 'record not found'
        redirect_to :users
      end
    end

    def authenticate_user_admin
      unless current_user.admin or @user == current_user
        flash[:notice] = 'you do not have the permission to edit a user'
        redirect_to :users
      end
    end

    def sorting_valid?
      (['desc', 'asc'].include? params[:direction] and ['name', 'email'].include?(params[:order]))
    end

end
