class PostsController < ApplicationController

  def create
    @post = current_user.posts.create(permitted_params)
    #FIX: Dont use redirect back, Redirect on the basis of group_id in post
    #FIX: Render with post details filled in case of failed to create
    if params[:post][:group_id]
      redirect_to group_path(params[:post][:group_id])
    else
      redirect_to :root
    end
  end

  #FIX: This should be private method -DONE
  private

    def permitted_params
      params.require(:post).permit(:content, :group_id, document_attributes: [:attachment, :id])
    end

end