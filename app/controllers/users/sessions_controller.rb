class Users::SessionsController < Devise::SessionsController

  #FIX: This logic can be moved to model.
  # see here: http://stackoverflow.com/questions/15864554/check-if-user-is-active-before-allowing-user-to-sign-in-with-devise-rails
  def create
    if User.find_by(email: params[:user][:email]).enabled
      self.resource = warden.authenticate!(auth_options)
      set_flash_message(:notice, :signed_in) if is_flashing_format?
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      redirect_to :new_user_session
    end
  end

end