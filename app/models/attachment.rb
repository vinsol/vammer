class Attachment < ActiveRecord::Base

  belongs_to :attachment, polymorphic: true

  mount_uploader :attachment, AttachmentUploader
end
