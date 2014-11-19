class CommentSerializer < ActiveModel::Serializer
  # attributes :team_name, :date_updated, :multimedia, :team_url, :stadium_address, :finances
  # has_many :players
  # has_many :games
  # delegate :post_comment_likes_path, :to => :scope
  attributes :comment_description, :image_url, :like_path, :user_name, :post_id, :comment_destroy_path, :attachment_destroy_paths
  # delegate :current_user, :to => :scope
  # serialization_scope :post_comment_likes_path
  has_many :document_files

  def comment_description
    object.content
  end

  def image_url
    object.user.image ? object.user.image.attachment.url(:thumb) : 'no_image'
  end

  def like_path
    # debugger
    # post_comment_likes_path(object.post, object)
  end

  def user_name
    object.user.name
  end

  # def attachments_url
  #   object.document_files.map do |attach|
  #     attach.attachment.url
  #   end
  # end

  def post_id
    object.post_id
  end

  def comment_destroy_path
    # post_comment_path(object.post, object)
  end

  def attachment_destroy_paths
    # attachment_ids = @comment.document_file_ids
    # attachment_destroy_paths = attachment_ids.map do |attachment_id|
    #   attachment_path(attachment_id)
    # end
  end

  # def team_name
  #     "#{object.city} #{object.name}"
  # end

  # def date_updated
  #   object.updated_at.to_i
  # end

  # def team_url
  #     "http://www.nfl.com/#{obje.ctcity}"
  # end

  # def stadium
  #     stadium = object.stadium
  #     "#{stadium.address}, #{stadium.city} #{stadium.state}, #{stadium.zip}"
  # end

  # def multimedia
  #     object.team_logo
  # end

  # def players
  #     object.players.collect { |player| [player.name, player.number, player.age]}
  # end

  # def finances
  #     if current_user.is_admin?
  #       {:revenue => object.revenue, :profit => object.profit, :costs => object.costs}
  #     else
  #       {}
  #     end
  # end

end