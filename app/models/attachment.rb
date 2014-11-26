#FIXME_AB: There are database indexes missing on almost all tables. -DONE
class Attachment < ActiveRecord::Base

  #FIX: Rename association to :attachable
  belongs_to :attachable, polymorphic: true

end