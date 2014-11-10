#FIX: Rename to HomeController
class HomeController < ApplicationController

  before_action :fetch_user_groups

  def index
    @post = Post.new
    @post.documents.build
    fetch_posts  
  end

end