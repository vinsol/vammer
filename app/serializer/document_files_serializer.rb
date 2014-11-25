class DocumentFilesSerializer < BaseSerializer

  attributes :attachments_url, :attachment_destroy_paths, :attachment_id, :attachment_name, :attachment_logo, :is_image

  def attachment_name
    object.attachment_file_name
  end

  def attachment_logo
    object.attachment_content_type.split('/').last + '.png'
  end

  def attachments_url
    object.attachment.url
  end

  def attachment_id
    object.id.to_s
  end

  def attachment_destroy_paths
    attachment_path(object.id)
  end

  def is_image
    object.attachment_content_type.split('/').first == 'image'
  end

end