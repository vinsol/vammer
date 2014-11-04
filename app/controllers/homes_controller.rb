class HomesController < ApplicationController

  def index
    @post = Post.new
    @post.build_document
    @posts = Post.all
  end

end