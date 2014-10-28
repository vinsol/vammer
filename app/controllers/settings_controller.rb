class SettingsController < ApplicationController

  before_action :authenticate_admin

  # fix- This may not be required. Lets discuss. -DONE

  def update
    params[:value].each do |current_setting|
      setting = Setting.where(id: current_setting.first).first
      setting.update(value: current_setting.second) if setting
    end
    flash[:notice] = 'Setting is successfully updated'
    redirect_to settings_edit_path
    # Move following line of code to before_action. Redirect to root page if no setting object exists.
    # fix- Below code wont work if there are more than one keys need to be updated.
    #       Discuss with me if unclear. -DONE
      # fix- Don't use redirect to back. Redirect to root page instead with a message -DONE
      # fix- Handle failure case also.
  end

  private

    def authenticate_admin
      #FIX: Set a flash message
      unless current_user.admin
        flash[:error] = 'Access Denied'
        redirect_to :root
      end
    end

end