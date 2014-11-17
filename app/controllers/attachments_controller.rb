class AttachmentsController < ApplicationController

  before_action :fetch_attachment, :allow_edit

  def destroy
    #FIX: What if #destroy fails
    @attachment.destroy
    respond_to do |format|
      #FIX: Render with some status code
      format.json { render json: {} }
    end
  end

  private

    def redirect_path
      group_id = params[:group_id]
      if group_id
        group_path(group_id)
      else
        :root
      end
    end

    def fetch_attachment
      @attachment = Attachment.where(id: params[:id]).first
    end

    def allow_edit
      #FIX: use #if
      #FIX: Make a method like #can_edit_attachment?(user)
      unless current_user.admin? or @attachment.attachment.user == current_user
        #FIX: As it is an ajax request, respond with json.
        flash[:notice] = t('access.failure', scope: :flash)
        redirect_to redirect_path
      end
    end

end