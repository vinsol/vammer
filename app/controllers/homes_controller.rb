#FIX: Rename to HomeController
class HomesController < ApplicationController

  before_action :fetch_groups

  def index
    @post = Post.new
    @post.build_document
    @posts = Post.order(created_at: :desc)
  end

end