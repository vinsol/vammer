class HomesController < ApplicationController

  before_action :fetch_groups

  def index
    initialize_posts
    initialize_comments
    @posts = Post.order(created_at: :desc)
  end

end