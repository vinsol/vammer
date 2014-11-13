class HashtagsController < ApplicationController

  def index
    @hashtags = SimpleHashtag::Hashtag.all
  end

  def show
    @hashtag = SimpleHashtag::Hashtag.find_by_name(params[:hashtag])
    @hashtagged = @hashtag.hashtaggables if @hashtag
    @hashtagged = @hashtagged.map do |hashtag|
      hashtag.try(:post) ? hashtag.post : hashtag
    end
    render 'posts/_post'
  end

end
