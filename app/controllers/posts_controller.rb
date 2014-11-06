class PostsController < ApplicationController

  def create
    @post = current_user.posts.new(permitted_params)
    #FIX: Dont use redirect back, Redirect on the basis of group_id in post -DONE
    #FIX: Render with post details filled in case of failed to create
    redirect_to redirect_path
  end

  #FIX: This should be private method -DONE
  private

    def redirect_path
      if params[:post][:group_id]
        group_path(params[:post][:group_id])
      else
        :root
      end
    end

    def permitted_params
      params.require(:post).permit(:content, :group_id, document_attributes: [:attachment, :id])
    end

end