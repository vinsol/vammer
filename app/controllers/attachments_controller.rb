class AttachmentsController < ApplicationController

  before_action :fetch_attachment, :allow_edit

  def destroy
    if @attachment.destroy
      #FIX: Move to a method #render_success
      comment = { message: t('attachments.destroy.success', scope: :message) }
    else
      #FIX: Move to a method #render_failure
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
      #FIX: In one line
      unless @attachment
        handle_response
      end
    end

    def can_edit_attachment?(user)
      current_user.admin? or user == current_user
    end

    def allow_edit
      #FIX: Use association for `Object.const_get(@attachment.attachment_type).where(id: @attachment.attachment_id).first`
      user = Object.const_get(@attachment.attachment_type).where(id: @attachment.attachment_id).first.user
      #FIX: Use #unless
      if !can_edit_attachment?(user)
        handle_response
      end
    end

    #FIX: Rename to #render_with_access_denied
    def handle_response
      comment = {
        #FIX: Add status code
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