class UsersController < ApplicationController

  before_action :authenticate_user!
  # after_action :set_password_mail

  def index
  end

end