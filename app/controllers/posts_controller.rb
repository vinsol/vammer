class PostsController < ApplicationController

  def create
    @post = current_user.posts.create(permitted_params)
    redirect_to :back, flash: { error: @post.errors.full_messages }
  end

  def permitted_params
    params.require(:post).permit(:content, :group_id, upload_attributes: [:attachment, :id])
  end

end