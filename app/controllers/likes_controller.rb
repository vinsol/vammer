#FIX: Rename to HomeController
class LikesController < ApplicationController

  before_action :fetch_likeable

  def create
    like = current_user.likes.create
    @likeable.likes << like
    redirect_to redirect_path
  end

  def destroy
    like = Like.where(id: params[:id]).first
    like.destroy
    redirect_to redirect_path
  end

  private

    def fetch_likeable
      if params[:comment_id]
        @likeable = Comment.where(id: params[:comment_id]).first
      else
        @likeable = Post.where(id: params[:post_id]).first
      end
    end

    def redirect_path
      path = @likeable.try(:group) || @likeable.post
      if path
        group_path(path.group_id)
      else
        :root
      end
    end

end