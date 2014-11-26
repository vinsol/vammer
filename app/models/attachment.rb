class Attachment < ActiveRecord::Base

  #FIX: Rename association to :attachable
  belongs_to :attachable, polymorphic: true

end