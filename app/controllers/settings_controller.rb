class SettingsController < ApplicationController

  before_action :authenticate_admin

  def update
    params[:value].each do |current_setting|
      setting = Setting.where(id: current_setting.first).first
      setting.update(value: current_setting.second) if setting
    end
    flash[:notice] = 'Setting is successfully updated'
    redirect_to settings_edit_path
  end

  private

    def authenticate_admin
      unless current_user.admin
        flash[:error] = 'Access Denied'
        redirect_to :root
      end
    end

end