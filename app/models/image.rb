class Image < Attachment

  has_attached_file :attachment, :styles => { :original => '100x100>', :thumb => '50x50>' }

  validates_attachment_content_type :attachment, :content_type => /\Aimage\/.*\Z/

end