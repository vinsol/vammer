class AttachmentsController < ApplicationController

  before_action :fetch_attachment, :allow_edit

  def destroy
    if @attachment.destroy
      comment = { message: t('attachments.destroy.success', scope: :message) }
    else
      comment = { error: t('attachments.destroy.failure', scope: :message) }
    end
    #FIX: Render with some status code
    render_on_error(comment)
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
      unless @attachment
        handle_response
      end
    end

    def can_edit_attachment?(user)
      current_user.admin? or user == current_user
    end

    def allow_edit
      user = Object.const_get(@attachment.attachment_type).where(id: @attachment.attachment_id).first.user
      if !can_edit_attachment?(user)
        handle_response
      end
    end

    def handle_response
      comment = {
        error: t('comments.record.failure', scope: :message)
      }
      render_on_error(comment)
    end

    def render_on_error(comment)
      respond_to do |format|
        format.json { render json: comment }
      end
    end

end