class CommentsController < ApplicationController

  before_action :fetch_comment, :authenticate_user_admin, only: [:destroy]
  before_action :fetch_post

  def create
    #FIX: fetching post should be in a before_action DONE
    #FIX: Move to a method #initialize_comment DONE
    initialize_comment
    unless @comment.save
      comment = {
        error: t('comments.create.failure', scope: :message)
      }
      render_on_error(comment)
    end

    #FIX: Use gem ActiveModelSerializer for preparing comment json DONE
    respond_to do |format|
      format.json { render json: @comment, serializer: CommentSerializer }
    end
  end

  def destroy
    if @comment.destroy
      comment = { message: t('comments.destroy.success', scope: :message) }
    else
      comment = { error: t('comments.destroy.failure', scope: :message) }
    end
      render_on_error(comment)
  end

  private

    def fetch_attachments
      @comment.document_files.map do |attach|
        attach.attachment
      end
    end

    def permitted_params
      params.require(:comment).permit(:content, document_files_attributes: [:attachment, :id, :_destroy])
    end

    def fetch_comment
      #FIX: Use #where DONE
      #FIX: What if comment is not found. Render json. DONE
      @comment = Comment.where(id: params[:id]).first
      unless @comment
        handle_response
      end
    end

    def fetch_post
      @post = Post.where(id: params[:post_id]).first
      unless @post
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

    def authenticate_user_admin
      unless current_user.admin? or @comment.user == current_user
        handle_response
      end
    end

    def initialize_comment
      @comment = @post.comments.new(permitted_params)
      @comment.user_id = current_user.id
    end

end