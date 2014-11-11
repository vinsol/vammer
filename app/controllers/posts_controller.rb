class PostsController < ApplicationController

  before_action :fetch_post, :authenticate_user_admin, only: [:destroy]

  def create
    @post = current_user.posts.new(permitted_params)
    #FIX: Render with post details filled in case of failed to create
    if @post.save
      flash[:notice] = t('.success', scope: :flash)
      redirect_to redirect_path
    else
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

  #FIX: This should be private method -DONE
  private

    def render_path
      initialize_comments
      initialize_post
      fetch_form_associations
      #FIX: Use @post.group_id
      if @post.group_id
        @group = @post.group
        'groups/show'
      else
        'home/index'
      end
    end

    #FIX: Rename to #fetch_form_associations and this should be called from the inside the action
    def fetch_form_associations
      #FIX: Define a method #fetch_posts and call from here
      fetch_posts
      fetch_user_groups
    end

    def redirect_path
      #FIX: Use @post.group_id -DONE
      if @post.group_id
        group_path(@post.group_id)
      else
        :root
      end
    end

    def permitted_params
      params.require(:post).permit(:content, :group_id, documents_attributes: [:attachment, :id, :_destroy])
    end

    def fetch_post
      @post = Post.where(id: params[:id]).first
    end

    def authenticate_user_admin
      unless current_user.admin? or @post.user == current_user
        flash[:notice] = t('access.failure', scope: :flash)
        redirect_to :root
      end
    end

end