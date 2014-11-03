class PostsController < ApplicationController

  def create
    post = current_user.posts.create(permitted_params)
    redirect_to :back
  end

  def permitted_params
    params.require(:post).permit(:content, :group_id, attachment_attributes: [:attachment, :id])
  end

end