class PostsController < ApplicationController

  def create
    @post = current_user.posts.new(permitted_params)
    #FIX: Render with post details filled in case of failed to create
    if @post.save
      redirect_to redirect_path
    else
      render render_path
    end
  end

  private

    def render_path
      initialize_render_path
      #FIX: Use @post.group_id
      if params[:post][:group_id]
        @group = Group.where(id: params[:post][:group_id]).first
        'groups/show'
      else
        'homes/index'
      end
    end

    #FIX: Rename to #fetch_form_associations and this should be called from the inside the action
    def initialize_render_path
      #FIX: Define a method #fetch_posts and call from here
      @posts = Post.order(created_at: :desc)
      fetch_groups
      @post.build_document
    end

    def redirect_path
      #FIX: Use @post.group_id
      if params[:post][:group_id]
        group_path(params[:post][:group_id])
      else
        :root
      end
    end

    def permitted_params
      params.require(:post).permit(:content, :group_id, document_attributes: [:attachment, :id])
    end

end