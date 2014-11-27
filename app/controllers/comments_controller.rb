class CommentsController < ApplicationController

  before_action :fetch_comment, :authenticate_user_admin, only: [:destroy, :like]
  before_action :fetch_post
  before_action :fetch_like, only: :unlike

  def create
    initialize_comment
    if @comment.save
      #FIX: Move to model
      CommentMailer.notify_on_create(current_user, @comment.user, @comment.post.id).deliver
      respond_to do |format|
        format.json { render json: @comment, serializer: CommentSerializer }
      end
    else
      comment = { error: t('comments.create.failure', scope: :message) }
      render_on_error(comment)
    end
  end

  def destroy
    if @comment.destroy
      #FIX: Use a separate method for rendering success, #render_success
      comment = { message: t('comments.destroy.success', scope: :message) }
    else
      comment = { error: t('comments.destroy.failure', scope: :message) }
    end
    #FIX: Indentation
      render_on_error(comment)
  end


  def like
    like = current_user.likes.build
    #FIX: Check if #push saves the record too?
    @comment.likes.push like
    if like.save
      #FIX: Move to callback in Like
      CommentMailer.notify_on_like_unlike(current_user, @comment.user, @comment.post.id).deliver
      #FIX: Use single method for success of like, unlike. e.g. #render_like_success(like)
      like_successful(like)
    else
      #FIX: Use single method for failure of like, unlike. e.g. #render_like_failure(is_like)
      like_unsuccessful
    end
  end

  def unlike
    @comment = @like.likeable
    if @like.destroy
      #FIX: Remove this. We should not send mail on unlike.
      CommentMailer.notify_on_like_unlike(current_user, @comment.user, @comment.post.id).deliver
      unlike_successful
    else
      unlike_unsuccessful
    end
  end

  private

    def unlike_successful
      like_path = post_comment_like_path(@comment.post, @comment)
      render_like_unlike_successful(like_path)
    end

    def unlike_unsuccessful
      like = { error: t('comments.unlike.failure', scope: :message) }
      render_error_response_for_like_unlike(like)      
    end

    def render_like_unlike_successful(like_path)
      respond_to do |format|
        #FIX: Use #unlike_path key
        result = {count: @comment.likes.count, like_path: like_path}
        format.json { render json: result}
      end
    end

    def like_successful(like)
      like_path = post_comment_unlike_path(@post, @comment, like)
      render_like_unlike_successful(like_path)
    end

    def like_unsuccessful
      like = { error: t('comments.like.failure', scope: :message) }
      render_error_response_for_like_unlike(like)
    end

    def render_error_response_for_like_unlike(like)
      respond_to do |format|
        format.json { render json: like }
      end
    end

    #FIX: Remove if not being used
    def fetch_attachments
      @comment.comment_documents.map do |attach|
        attach.attachment
      end
    end

    def permitted_params
      params.require(:comment).permit(:content, comment_documents_attributes: [:attachment, :id, :_destroy])
    end

    def fetch_comment
      @comment = Comment.where(id: params[:comment_id] || params[:id]).first
      unless @comment
        handle_response
      end
    end

    def fetch_like
      @like = Like.where(id: params[:id]).first
      unless @like
        handle_response_like
      end
    end

    def handle_response_like
      like = { error: t('comments.unlike.failure', scope: :message) }
      respond_to do |format|
        format.json { render json: like }
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

    #FIX: Rename #render_failure
    def render_on_error(comment)
      respond_to do |format|
        #FIX: Add status code. Please fix this everywhere.
        format.json { render json: comment }
      end
    end

    #FIX: Rename. Use something specific
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