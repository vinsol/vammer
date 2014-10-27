class Users::PasswordsController < Devise::PasswordsController

  #FIX: Is this overriding of #update necessary? Can we do some configuration instead?
  # If not, please add a one line comment above method definition to specify why did we override this.

  # this method is overridden because we have to save user's name when we set the password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    #FIX: Can we use #resource_params instead of params[:user] -DONE

    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message(:notice, flash_message) if is_flashing_format?
      sign_in(resource_name, resource)
      respond_with resource, location: after_resetting_password_path_for(resource)
    else
      respond_with resource
    end
  end

end