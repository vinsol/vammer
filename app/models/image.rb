class Image < Attachment

  #FIX: Ruby 2 syntax -DONE
  has_attached_file :attachment, styles: { original: '100x100>', thumb: '50x50>' }

  #FIX: Ruby 2 syntax -DONE
  validates_attachment_content_type :attachment, content_type: /\Aimage\/.*\Z/

end