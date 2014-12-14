class HashtagsController < ApplicationController

  before_action :fetch_hashtags, only: :show

  def index
    @hashtags = SimpleHashtag::Hashtag.all
  end

  def show
    #FIX: Fetch hashtag in before_action. Handle failure case. DONE
    #FIX: Remove if condition. It will be handled in above before_action DONE
    #FIX: Use #compact! to remove any nil entries, if present DONE
    collect_post_form_hashtags
    @hashtagged.uniq.compact!
    #FIX: Create a template show.html.erb and render partial from there DONE
  end

  private

    def collect_post_form_hashtags
      @hashtagged = @hashtagged.map do |hashtag|
        #FIX: Use #respond_to? instead of #try? DONE
        hashtag.respond_to?(:post) ? hashtag.post : hashtag
      end
    end

    def fetch_hashtags
      @hashtag = SimpleHashtag::Hashtag.find_by_name(params[:hashtag])
      if @hashtag
        @hashtagged = @hashtag.hashtaggables
      else
        flash[:error] = t('.failure', scope: :flash)
        redirect_to :root
      end
    end

end
