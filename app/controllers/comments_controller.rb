class CommentsController < ApplicationController

  before_action :fetch_comment, :authenticate_user_admin, only: [:destroy]

  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.new(permitted_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to redirect_path
    else
      render render_path
    end
  end

  def destroy
    @comment.destroy
    redirect_to redirect_path
  end

  private

    def render_path
      fetch_user_groups
      initialize_render_path
      initialize_posts
      if @comment.post.group_id
        @group = @comment.post.group
        'groups/show'
      else
        'home/index'
      end
    end

    def initialize_render_path
      @posts = Post.order(created_at: :desc)
      initialize_posts
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