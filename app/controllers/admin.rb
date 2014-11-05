class Admin < ApplicationController

  before_action :authenticate_admin

  private

    def authenticate_admin
      unless current_user.admin?
        #FIX: This should be error -DONE
        flash[:error] = t('access.failure', scope: :flash)
        redirect_to :root
      end
    end

end