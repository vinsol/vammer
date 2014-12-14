module ControllerMacros

  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in :user, user
  end

end