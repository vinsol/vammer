class CommentsController < ApplicationController

  before_action :fetch_comment, :authenticate_user_admin, only: [:destroy]

  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.new(permitted_params)
    @comment.user_id = current_user.id
    @comment.save
    attachments = fetch_attachments
    result = build_result(attachments)
    respond_to do |format|
      format.json { render json: result.as_json }
    end
  end

  def destroy
    if @comment.destroy
      flash[:notice] = t('.success', scope: :flash)
    else
      flash[:error] = t('.failure', scope: :flash)
    end
    respond_to do |format|
      format.json { render json: {} }
    end
  end

  private

    def build_result(attachments)
      image = @comment.user.image ? @comment.user.image.attachment.url(:thumb) : 'no_image'
      result = {
        comment: @comment,
        image: image,
        like_path: post_comment_likes_path(@comment.post, @comment),
        user: @comment.user,
        attachment: attachments.map(&:url),
        post_id: @comment.post.id,
        comment_destroy_path: post_comment_path(@comment.post, @comment),
        attachment_destroy_paths: destroy_attachment_path
      }
    end

    def destroy_attachment_path
      attachment_ids = @comment.document_file_ids
      attachment_destroy_paths = attachment_ids.map do |attachment_id|
        attachment_path(attachment_id)
      end
    end

    def fetch_attachments
      @comment.document_files.map do |attach|
        attach.attachment
      end
    end

    def redirect_path
      if @comment.post.group
        group_path(@comment.post.group_id)
      else
        :root
      end
    end

    def permitted_params
      params.require(:comment).permit(:content, document_files_attributes: [:attachment, :id, :_destroy] )
    end

    def fetch_comment
      @comment = Comment.find(params[:id])
    end

    def authenticate_user_admin
      unless current_user.admin? or @comment.user == current_user
        flash[:notice] = t('access.failure', scope: :flash)
        redirect_to redirect_path
      end
    end

end