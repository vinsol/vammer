class Users::ConfirmationsController < Devise::ConfirmationsController

  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?
    if resource.errors.empty?
      @resource = resource
      redirect_to edit_user_password_path(@resource, reset_password_token: resource.set_token)
    end
  end

end
