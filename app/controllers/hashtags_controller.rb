class HashtagsController < ApplicationController

  def index
    @hashtags = SimpleHashtag::Hashtag.all
  end

  def show
    #FIX: Fetch hashtag in before_action. Handle failure case.
    @hashtag = SimpleHashtag::Hashtag.find_by_name(params[:hashtag])
    #FIX: Remove if condition. It will be handled in above before_action
    @hashtagged = @hashtag.hashtaggables if @hashtag
    @hashtagged = @hashtagged.map do |hashtag|
      #FIX: Use #respond_to? instead of #try?
      hashtag.try(:post) ? hashtag.post : hashtag
    end
    #FIX: Use #compact! to remove any nil entries, if present
    @hashtagged.uniq!
    #FIX: Create a template show.html.erb and render partial from there
    render 'posts/_post'
  end

end
