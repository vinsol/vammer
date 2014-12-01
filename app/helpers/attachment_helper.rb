module AttachmentHelper

  #FIXME_AB: Method name is inappropriate. should be something like attachment_icon
  def attachment_type(image)
    image_tag image.attachment_content_type.split('/').last + '.png'
  end

end