class AttachmentSerializer < ActiveModel::Serializer

  attributes :attachments_url

  def attachments_url
    debugger
    object.attachment.url
  end

  # def comment_description
  #   object.content
  # end

  # def image_url
  #   object.user.image ? object.user.image.attachment.url(:thumb) : 'no_image'
  # end

  # def like_path
  #   # post_comment_likes_path(object.post, object)
  # end

  # def user_name
  #   object.user.name
  # end

  # def attachments_url
  #   object.document_files.map do |attach|
  #     attach.attachment.url
  #   end
  # end

  # def post_id
  #   object.post_id
  # end

  # def comment_destroy_path
  #   # post_comment_path(object.post, object)
  # end

  # def attachment_destroy_paths
  #   # attachment_ids = @comment.document_file_ids
  #   # attachment_destroy_paths = attachment_ids.map do |attachment_id|
  #   #   attachment_path(attachment_id)
  #   # end
  # end

end