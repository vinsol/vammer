#FIXME_AB: There are database indexes missing on almost all tables.
class Attachment < ActiveRecord::Base

  belongs_to :attachment, polymorphic: true

end