class LikesController < ApplicationController

  before_action :fetch_likeable, only: [:create]

  def create
    like = current_user.likes.create
    @likeable.likes.push like
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
      if params[:group_id]
        group_path(params[:group_id])
      else
        :root
      end
    end

end