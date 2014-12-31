class CommentSerializer < BaseSerializer

  attributes :comment_description, :image_url, :like_path, :user_name, :post_id, :comment_destroy_path

  has_many :comment_documents, serializer: CommentDocumentSerializer

  def comment_description
    object.content
  end

  def image_url
    object.user.image ? object.user.image.attachment.url(:thumb) : 'no_image'
  end

  def like_path
    post_comment_like_path(object.post, object)
  end

  def user_name
    object.user.name
  end

  def post_id
    object.post_id
  end

  def comment_destroy_path
    post_comment_path(object.post, object)
  end

end