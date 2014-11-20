class PostsController < ApplicationController

  before_action :fetch_post, only: [:destroy]
  before_action :fetch_post_for_like, only: [:like, :unlike]
  before_action :fetch_like, only: [:unlike]

  def create
    @post = current_user.posts.new(permitted_params)
    if @post.save
      flash[:notice] = t('.success', scope: :flash)
      redirect_to redirect_path
    else
      fetch_form_associations
      flash[:error] = t('.failure', scope: :flash)
      render render_path
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = t('.success', scope: :flash)
    else
      flash[:error] = t('.failure', scope: :flash)
    end
    redirect_to :root
  end

  def like
    #FIX: First initialize like object and then assign to user, then save. Handle success/failure
    like = current_user.likes.build
    @post.likes.push like
    if like.save
      like_successful(like)
    else
      like_unsuccessful
    end
  end

  def unlike
    #FIX: Fetch in before_action
    @post = @like.likeable
    #FIX: Handle success/failure
    if @like.destroy
      unlike_successful
    else
      unlike_unsuccessful
    end
  end

  private

    def unlike_successful
      like_path = post_like_path(@post)
      render_like_unlike_successful(like_path)
    end

    def like_successful(like)
      like_path = post_unlike_path(@post.id, like.id)
      render_like_unlike_successful(like_path)
    end

    def render_like_unlike_successful(like_path)
      respond_to do |format|
        #FIX: Use #unlike_path key
        result = {count: @post.likes.count, like_path: like_path}
        format.json { render json: result}
      end
    end

    def unlike_unsuccessful
      like = { error: t('comments.unlike.failure', scope: :message) }
      render_error_response_for_like_unlike(like)      
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

    def fetch_post_for_like
      @post = Post.where(id: params[:post_id]).first
      unless @post
        handle_response
      end
    end

    def handle_response
      like = { error: t('posts.like.failure', scope: :message) }
      respond_to do |format|
        format.json { render json: like }
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
      @post = Post.where(id: params[:id]).first
      unless @post
        flash[:error] = t('flash.record.failure')
        redirect_to redirect_path
      end
    end

    def render_path
      @post.group_id ? 'groups/show' : 'home/index'
    end

    def fetch_form_associations
      fetch_posts
      fetch_user_groups
      @post.documents.build
      initialize_comment
    end

    def redirect_path
      if @post.group_id
        group_path(@post.group_id)
      else
        :root
      end
    end

    def permitted_params
      params.require(:post).permit(:content, :group_id, documents_attributes: [:attachment, :id])
    end

end