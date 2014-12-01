class Admin::SettingsController < Admin::BaseController

  def edit
    @setting = Setting.first
    @setting.build_image unless @setting.image
  end

  def update
    #FIXME_AB: before filter?
    setting = Setting.first
    if setting.update(permitted_params)
      flash[:notice] = t('.success', scope: :flash)
    else
      #FIXME_AB: This won't display error messages
      flash[:error] = t('.failure', scope: :flash)
    end
    redirect_to admin_settings_edit_path
  end

  private
    
    def permitted_params
      params.require(:setting).permit(image_attributes: [:attachment])
    end

end