class Admin::SettingsController < Admin

  def edit
    @setting = Setting.first
    @setting.build_image unless @setting.image
  end

  def update
    setting = Setting.first
    if setting.update(permitted_params)
      flash[:notice] = t('.success', scope: :flash)
    else
      flash[:error] = t('.failure', scope: :flash)
    end
    redirect_to admin_settings_edit_path
  end

  private
    
    def permitted_params
      params.require(:setting).permit(image_attributes: [:attachment])
    end

end