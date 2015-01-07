class HomeController < ApplicationController

  before_action :fetch_user_groups

  def index
    initialize_comment
    initialize_post
    fetch_posts
  end

end