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
      @post.build_document
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
      params.require(:post).permit(:content, :group_id, document_attributes: [:attachment, :id])
    end

end