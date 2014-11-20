class DocumentFilesSerializer < BaseSerializer

  attributes :attachments_url, :attachment_destroy_paths

  def attachments_url
    object.attachment.url
  end

  def attachment_destroy_paths
    attachment_path(object.id)
  end

end