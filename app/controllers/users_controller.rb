class UsersController < ApplicationController

  def index
    #FIX: Use if instead of unless
    unless params[:direction]
      @users = User.order(name: :asc).page params[:page]
    else
      @users = User.order( params[:order] => params[:direction].to_sym).page params[:page]
    end
  end

end