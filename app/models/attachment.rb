class Attachment < ActiveRecord::Base

  belongs_to :attachment, polymorphic: true

end