class SettingsController < ApplicationController

  before_action :admin

  def new
    @setting = Setting.new
  end

  def create
    setting = Setting.new(allowed_params)
    setting.save
  end

  def update
    setting = Setting.first
    unless setting.update_attribute(:value, allowed_params[:value])
      redirect_to :back
    end
  end

  def edit
    @setting = Setting.first
  end

  def allowed_params
    params.require(:setting).permit(:value, :key)
  end

  def admin
    redirect_to :root unless current_user.admin
  end

end