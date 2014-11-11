#FIX: Rename to HomeController
class LikesController < ApplicationController

  before_action :fetch_post

  def create
    like = current_user.likes.create
    @post.likes << like
    redirect_to redirect_path
  end

  def destroy
    like = Like.where(id: params[:id]).first
    like.destroy
    redirect_to redirect_path
  end

  private

    def fetch_post
      @post = Post.where(id: params[:post_id]).first
    end

    def redirect_path
      if @post.group_id
        group_path(@post.group_id)
      else
        :root
      end
    end

end