#FIX: Create new classes PostDocument, CommentDocument and inherit them from Document. DONE
class Document < Attachment

  has_attached_file :attachment

  VALID_FILE_TYPE = %w(application/pdf application/msword
    application/vnd.ms-excel application/mspowerpoint)
  validates_attachment_content_type :attachment, content_type: [/\Aimage\/.*\Z/, VALID_FILE_TYPE]

end