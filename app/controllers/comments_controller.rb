class CommentsController < ApplicationController

  before_action :fetch_comment, :authenticate_user_admin, only: [:destroy]

  def create
    #FIX: fetching post should be in a before_action
    post = Post.find(params[:post_id])
    #FIX: Move to a method #initialize_comment
    @comment = post.comments.new(permitted_params)
    @comment.user_id = current_user.id
    @comment.save
    # attachments = fetch_attachments
    #FIX: Use gem ActiveModelSerializer for preparing comment json
    # result = build_result(attachments)
    respond_to do |format|
      format.json { render json: @comment }
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

    #FIX: Move this to serializer. Create CommentSerializer.
    # def build_result(attachments)

    #   #FIX: Do not send string 'no_image'. Send blank value instead.
    #   image = @comment.user.image ? @comment.user.image.attachment.url(:thumb) : 'no_image'
    #   result = {
    #     #FIX: Do not send complete @comment object in json. Send just required data like content, time_since_created_at
    #     comment: @comment,
    #     #FIX: Use key #user_image and send url string.
    #     image: image,
    #     like_path: post_comment_likes_path(@comment.post, @comment),
    #     #FIX: Use #user_name as key and do not send object.
    #     user: @comment.user,
    #     #FIX: It should be sent as { attachments: [{ :url, :destroy_path }] }. Create an AttachmentSerializer for this.
    #     attachment: attachments.map(&:url),
    #     post_id: @comment.post_id,
    #     #FIX: Use #destroy_path
    #     comment_destroy_path: post_comment_path(@comment.post, @comment),
    #     attachment_destroy_paths: destroy_attachment_path
    #   }
    # end

    # def destroy_attachment_path
    #   attachment_ids = @comment.document_file_ids
    #   attachment_destroy_paths = attachment_ids.map do |attachment_id|
    #     attachment_path(attachment_id)
    #   end
    # end

    def fetch_attachments
      @comment.document_files.map do |attach|
        attach.attachment
      end
    end

    #FIX: This is not required
    # def redirect_path
    #   if @comment.post.group
    #     group_path(@comment.post.group_id)
    #   else
    #     :root
    #   end
    # end

    def permitted_params
      params.require(:comment).permit(:content, document_files_attributes: [:attachment, :id, :_destroy])
    end

    def fetch_comment
      #FIX: Use #where
      #FIX: What if comment is not found. Render json.
      @comment = Comment.where(id: params[:id]).first
      unless @comment
        render_on_error
      end
    end

    def render_on_error
      respond_to do |format|
        comment = {
          error: 'comment not found'
        }
        format.json { render json: comment }
      end
    end

    def authenticate_user_admin
      unless current_user.admin? or @comment.user == current_user
        #FIX: Render json
        flash[:notice] = t('access.failure', scope: :flash)
        render_on_error
      end
    end

end