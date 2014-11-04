class HomesController < ApplicationController

  before_action :fetch_groups

  def index
    @post = Post.new
    @post.build_document
    @posts = Post.all
  end

end