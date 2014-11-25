module AttachmentHelper

  def attachment_type(image)
    image_tag image.attachment_content_type.split('/').last + '.png'
  end

end