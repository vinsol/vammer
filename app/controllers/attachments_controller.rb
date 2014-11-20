class AttachmentsController < ApplicationController

  before_action :fetch_attachment, :allow_edit

  def destroy
    if @attachment.destroy
      comment = { message: t('attachments.destroy.success', scope: :message) }
    else
      comment = { error: t('attachments.destroy.failure', scope: :message) }
    end
    render_on_error(comment)
    #FIX: What if #destroy fails DONE
    #FIX: Render with some status code
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
      #FIX: use #if DONE
      #FIX: Make a method like #can_edit_attachment?(user) DONE
      if !can_edit_attachment?(@attachment.attachment.user)
        #FIX: As it is an ajax request, respond with json. DONE
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