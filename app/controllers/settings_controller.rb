class SettingsController < ApplicationController

  # fix- Rename. Use some meaningful name.
  before_action :authenticate_admin

  # def new
    # @settings = Setting.new
  # end

  # fix- This may not be required. Lets discuss.
  def create

    params[:key].size.times do |index|
      setting = Setting.find_by(key: params[:key][index][index.to_s])
      if setting
        setting.update_column(:value, params[:value][index][index.to_s])
      else
        Setting.create(key: params[:key][index][index.to_s], value: params[:value][index][index.to_s])
      end
    end

    redirect_to :root
  end

  def update
    # Move following line of code to before_action. Redirect to root page if no setting object exists.
    # setting = Setting.first
    # fix- Below code wont work if there are more than one keys need to be updated.
    #       Discuss with me if unclear.
    # unless setting.update_attribute(:value, allowed_params[:value])
      # fix- Don't use redirect to back. Redirect to root page instead with a message
      # fix- Handle failure case also.
      # redirect_to :back
    # end
  end

  def edit
    # fix- This will not work. As there may be more than 1 keys i.e. Setting objects. A single Setting object stores 1 key/value pair
    # @setting = Setting.find_or_create_by(key: :logo)
  end

  def allowed_params
    # params.require(:setting).permit(:value, :key)
  end

  def authenticate_admin
    redirect_to :root unless current_user.admin
  end

end