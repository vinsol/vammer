class DocumentFile < Attachment

  has_attached_file :attachment

  #FIX: Keep only required formats. Add format for ppt also. DONE
  VALID_FILE_TYPE = %w(application/pdf application/msword
    application/msexcel application/mspowerpoint)
  validates_attachment_content_type :attachment, content_type: [/\Aimage\/.*\Z/, VALID_FILE_TYPE]

end