class HashtagsController < ApplicationController

  before_action :fetch_hashtags, only: :show

  def index
    @hashtags = SimpleHashtag::Hashtag.all
  end

  def show
    collect_post_form_hashtags
    @hashtagged.uniq.compact!
  end

  private

    #FIX: Rename #fetch_posts
    def collect_post_form_hashtags
      @hashtagged = @hashtagged.map do |hashtag|
        hashtag.respond_to?(:post) ? hashtag.post : hashtag
      end
    end

    def fetch_hashtags
      @hashtag = SimpleHashtag::Hashtag.find_by_name(params[:hashtag])
      if @hashtag
        #FIX: Move this to a method and call from #show. #fetch_hashtaggables
        @hashtagged = @hashtag.hashtaggables
      else
        flash[:error] = t('.failure', scope: :flash)
        redirect_to :root
      end
    end

end
