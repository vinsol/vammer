class Image < Attachment

  #FIX: Preserve aspect ratio. Use '>'
  #FIXME_AB: Learn about imagemagick geometry 
  has_attached_file :attachment, styles: { original: '100x100#', thumb: '50x50#', logo: '25x25#' }, default_url: 'missing.jpg'

  #FIXME_AB: regexp in constant hash so that we can reuse them.
  validates_attachment_content_type :attachment,
                                    content_type: /\Aimage\/.*\Z/,
                                    size: { less_than: 2.megabytes }

end