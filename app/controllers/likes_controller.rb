#FIX: Move #create, #destroy to PostsController, CommentsController and create actions #like, #unlike there.
class LikesController < ApplicationController

  before_action :fetch_likeable, only: [:create]

  def create
    #FIX: First initialize like object and then assign to user, then save. Handle success/failure
    like = current_user.likes.create
    @likeable.likes.push like
    like_path = params[:comment_id] ? like_path(like.id) : post_like_path(@likeable.id, like.id)
    respond_to do |format|
      #FIX: Use #unlike_path key
      result = {count: @likeable.likes.count, like_path: like_path}
      format.json { render json: result}
    end
  end

  def destroy
    #FIX: Fetch in before_action
    like = Like.where(id: params[:id]).first
    @likeable = like.likeable
    #FIX: Handle success/failure
    like.destroy
    like_path = like.likeable_type == 'Comment' ? post_comment_likes_path(like.likeable.post, like.likeable) : post_likes_path(like.likeable)
    respond_to do |format|
      result = {count: @likeable.likes.count, like_path: like_path}
      format.json { render json: result}
    end
  end

  private

    def fetch_likeable
      #FIX: Handle failure case, if object not found
      if params[:comment_id]
        @likeable = Comment.where(id: params[:comment_id]).first
      else
        @likeable = Post.where(id: params[:post_id]).first
      end
    end

end