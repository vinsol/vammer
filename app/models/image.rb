class Image < Attachment

  #FIXME_AB: Please read about the meaning of > in the image styles you have specified in below line. Also read about other options. DONE
  has_attached_file :attachment, styles: { original: '100x100#', thumb: '50x50#', logo: '25x25#' }, default_url: 'missing.jpg'

  validates_attachment_content_type :attachment,
                                    content_type: /\Aimage\/.*\Z/,
                                    size: { less_than: 2.megabytes }

  #FIXME_AB: We should also add some validation on the image size. like 2MB or so. Please confirm with PM DONE

end