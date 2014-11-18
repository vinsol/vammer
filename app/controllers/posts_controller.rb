class PostsController < ApplicationController

  before_action :fetch_post, only: :destroy

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


  private

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
      @group = @post.group if @post.group_id
    end

    def redirect_path
      if @post.try(:group_id)
        group_path(@post.group_id)
      else
        :root
      end
    end

    def permitted_params
      params.require(:post).permit(:content, :group_id, documents_attributes: [:attachment, :id])
    end

end