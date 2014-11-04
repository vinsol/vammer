class HomesController < ApplicationController

  def index
    @post = Post.new
    @post.build_document
    @posts = Post.order(created_at: :desc)
  end

end