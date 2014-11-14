class CommentsController < ApplicationController

  before_action :fetch_comment, :authenticate_user_admin, only: [:destroy]

  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.new(permitted_params)
    @comment.user_id = current_user.id
    @comment.save
    respond_to do |format|
      result = {
        comment: @comment,
        like_path: post_comment_likes_path(@comment.post, @comment),
        user: @comment.user,
        post_id: @comment.post.id,
      }
      format.json { render json: result }
    end
    # redirect_or_render
  end

  def destroy
    if @comment.destroy
      flash[:notice] = t('.success', scope: :flash)
    else
      flash[:error] = t('.failure', scope: :flash)
    end
    redirect_to redirect_path
  end

  private

    def redirect_or_render
      if @comment.save
        flash[:notice] = t('.success', scope: :flash)
        redirect_to redirect_path
      else
        flash[:error] = t('.failure', scope: :flash)
        render render_path
      end
    end

    def render_path
      fetch_user_groups
      initialize_render_path
      if @comment.post.group_id
        @group = @comment.post.group
        'groups/show'
      else
        'home/index'
      end
    end

    def initialize_render_path
      @posts = Post.order(created_at: :desc)
      initialize_post
    end

    def redirect_path
      debugger
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