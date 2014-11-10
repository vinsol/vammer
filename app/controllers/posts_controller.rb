class PostsController < ApplicationController

  def create
    @post = current_user.posts.new(permitted_params)
    #FIX: Dont use redirect back, Redirect on the basis of group_id in post -DONE
    #FIX: Render with post details filled in case of failed to create
    if @post.save
      redirect_to redirect_path
    else
      render render_path
    end
  end

  #FIX: This should be private method -DONE
  private

    def render_path
      initialize_render_path
      if params[:post][:group_id]
        @group = Group.where(id: params[:post][:group_id]).first
        'groups/show'
      else
        'homes/index'
      end
    end

    def initialize_render_path
      @posts = Post.order(created_at: :desc)
      fetch_groups
      @post.build_document
    end

    def redirect_path
      if params[:post][:group_id]
        group_path(params[:post][:group_id])
      else
        :root
      end
    end

    def permitted_params
      params.require(:post).permit(:content, :group_id, documents_attributes: [:attachment, :id, :_destroy])
    end

end