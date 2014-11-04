class Document < Attachment

  has_attached_file :attachment

  #FIX: Keep only required formats. Add format for ppt also.
  VALID_FILE_TYPE = %w(application/pdf application/msword 
    application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document
    application/msexcel application/vnd.ms-excel application/vnd.openxmlformats-officedocument.spreadsheetml.sheet)

  validates_attachment_content_type :attachment, :content_type => [/\Aimage\/.*\Z/, VALID_FILE_TYPE]

end