#FIX: Move this to namespace 'admin' -DONE
class Admin::SettingsController < Admin

  def edit
    @settings = Setting.all
  end

  def update
    params[:value].each do |current_setting|
      setting = Setting.where(id: current_setting.first).first
      setting.update(value: current_setting.second) if setting
    end
    flash[:notice] = t('.success', scope: :flash)
    redirect_to admin_settings_edit_path
  end

end