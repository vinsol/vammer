class UsersController < ApplicationController

  before_action :fetch_user, except: :index

  before_action :authenticate_user_admin, only: [:update, :edit]

  ALLOWED_PARAMS = %i(name date_of_birth mobile about_me job_title
                      admin joining_date enabled) +
                      [ image_attributes: %i(attachment id) ]

  def index
    @users = current_user.admin? ? User.all : User.where(enabled: true)
    sort_order
    sort_column
    @users = @users.order( params[:column] => params[:direction].to_sym).page params[:page]
  end

  def edit
    @user.build_image unless @user.image
  end

  def update
    if @user.update(permitted_params)
      flash[:notice] = t('.success', scope: :flash)
      redirect_to :users
    else
      flash[:notice] = t('.failure', scope: :flash)
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
        flash[:notice] = t('record.failure', scope: :flash)
        redirect_to :users
      end
    end

    def authenticate_user_admin
      unless current_user.admin? or @user == current_user
        flash[:notice] = t('access.failure', scope: :flash)
        redirect_to :users
      end
    end

end
