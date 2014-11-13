class LikesController < ApplicationController

  before_action :fetch_likeable, only: [:create]

  def create
    like = current_user.likes.create
    @likeable.likes.push like
    respond_to do |format|
      result = {count: @likeable.likes.count, like_path: post_like_path(@likeable.id, like.id)}
      format.json { render json: result}
    end
  end

  def destroy
    like = Like.where(id: params[:id]).first
    @likeable = like.likeable
    like.destroy
    respond_to do |format|
      result = {count: @likeable.likes.count, like_path: post_likes_path}
      format.json { render json: result}
    end
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