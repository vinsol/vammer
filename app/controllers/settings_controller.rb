class SettingsController < ApplicationController
  before_action :authenticate_user!

  def new
    if Setting.first
      @setting = Setting.first
    else
      @setting = Setting.new
    end
  end

  def create
    setting = Setting.new(allowed_params)
    setting.save
  end

  def update
    setting = Setting.first
    if setting.update_attribute(:value, allowed_params[:value])
    else
      redirect_to :back
    end
  end

  def allowed_params
    params.require(:setting).permit(:value, :key)
  end

end