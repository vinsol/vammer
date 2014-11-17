class PostsController < ApplicationController

  def create
    @post = current_user.posts.new(permitted_params)
    if @post.save
      redirect_to redirect_path
    else
      fetch_form_associations
      render render_path
    end
  end

  private

    def render_path
      @post.group_id ? 'groups/show' : 'home/index'
    end

    def fetch_form_associations
      fetch_posts
      fetch_user_groups
      @post.build_document
      @group = @post.group if @post.group_id
    end

    def redirect_path
      if @post.group_id
        group_path(@post.group_id)
      else
        :root
      end
    end

    def permitted_params
      params.require(:post).permit(:content, :group_id, document_attributes: [:attachment, :id])
    end

end