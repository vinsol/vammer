class UsersController < ApplicationController

  before_action :find_selected_user, except: [:index]
  before_action :authenticate_user_admin, only: [:update, :edit]

  ALLOWED_PARAMS = [:name, :date_of_birth, :mobile, :about_me, :job_title,
                   :admin, :joining_date, :enabled,
                    attachment_attributes: [:attachment_cache, :id, :attachment]]

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
    #FIX: In one line
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

    #FIX: Rename to #permitted_params
    def permitted_params
      #FIX: Make a constant to store all the permitted attributes
      params.require(:user).permit ALLOWED_PARAMS
    end

    #FIX: Use #where to fetch resources instead of #find
    def authenticate_user_admin
      #FIX: Display a flash message in case of redirect below
      unless current_user.admin or @user == current_user
        flash[:notice] = 'you do not have the permission to edit a user'
        redirect_to :users
      end
    end

    def find_selected_user

      @user = User.where(id: params[:id]).first
      unless @user
        flash[:notice] = 'record not found'
        redirect_to :users
      end

    end

end
