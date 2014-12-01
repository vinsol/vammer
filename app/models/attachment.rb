#FIXME_AB: indexes missing on this table
class Attachment < ActiveRecord::Base

  #FIXME_AB: Don't we need inverse_of? 
  belongs_to :attachable, polymorphic: true

end