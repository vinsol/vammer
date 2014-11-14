class AttachmentsController < ApplicationController

  before_action :fetch_attachment, :allow_edit

  def destroy
    @attachment.destroy
    redirect_to redirect_path
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
      unless current_user.admin? or @attachment.attachment.user == current_user
        flash[:notice] = t('access.failure', scope: :flash)
        redirect_to redirect_path
      end
    end

end