class SettingsController < ApplicationController

  # fix- Rename. Use some meaningful name. -DONE
  before_action :authenticate_admin

  # fix- This may not be required. Lets discuss. -DONE

  def edit

    @first_setting = Setting.find_or_create_by(key: :logo)
    @second_setting = Setting.find_or_create_by(key: :location)

    # fix- This will not work. As there may be more than 1 keys i.e. Setting objects. A single Setting object stores 1 key/value pair -DONE
  end

  def update
    params[:settings].each do |setting|
      @setting = Setting.find(setting.first)
      @setting.update(setting.second)
    end
    redirect_to '/settings/edit'
    # Move following line of code to before_action. Redirect to root page if no setting object exists.
    # fix- Below code wont work if there are more than one keys need to be updated.
    #       Discuss with me if unclear. -DONE
      # fix- Don't use redirect to back. Redirect to root page instead with a message -DONE
      # fix- Handle failure case also.
  end

  private

    def authenticate_admin
      redirect_to :root unless current_user.admin
    end

end