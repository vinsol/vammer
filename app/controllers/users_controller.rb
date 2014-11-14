class UsersController < ApplicationController

  before_action :fetch_user, except: :index

  before_action :authenticate_user_admin, only: [:update, :edit]

  ALLOWED_PARAMS = %i(name date_of_birth mobile about_me job_title
                      admin joining_date enabled) +
                      [ image_attributes: %i(attachment id) ]

  def index
    #FIXME_AB: Why not enabled is a scope
    respond_to do |format|
      format.html do
        @users = current_user.admin? ? User.all : User.where(enabled: true)
        #TODO will be used in next sprint
        # sort_order
        # sort_column
        #FIXME_AB: any column from params can be used for sorting.
        # @users = @users.order( params[:column] => params[:direction].to_sym).page params[:page]
      end
      format.json do
        data = { users: User.where('name like ? ', '%' + params[:term] + '%'),
                groups: Group.where('name like ? ', '%' + params[:term] + '%')
               }
        render json: data
      end
    end
    @users = current_user.admin? ? User.all : User.where(enabled: true)
  end

  def edit
    @user.build_image unless @user.image
  end

  def show
    initialize_comment
    initialize_post
    @posts = current_user.posts
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

    #FIXME_AB: Can we name it better?
    def authenticate_user_admin
      #FIXME_AB: or vs ||
      unless current_user.admin? || @user == current_user
        flash[:notice] = t('access.failure', scope: :flash)
        redirect_to :users
      end
    end

end
