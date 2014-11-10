class CommentsController < ApplicationController

  before_action :fetch_comment, :authenticate_user_admin, only: [:destroy]

  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.new(permitted_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to redirect_path
  end

  def destroy
    @comment.destroy
    redirect_to redirect_path
  end

  private

    def redirect_path
      if @comment.group_id.empty?
        :root
      else
        group_path(@comment.group_id)
      end
    end

    def permitted_params
      params.require(:comment).permit(:content, document_attributes: [:attachment] )
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