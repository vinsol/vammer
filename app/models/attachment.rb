class Attachment < ActiveRecord::Base

  belongs_to :attachment, polymorphic: true

  has_attached_file :attachment, :styles => { :original => '100x100>' }, url: '/:class/:id/:style.:extension', path: ':rails_root/public:url'

  validates_attachment_content_type :attachment, :content_type => /\Aimage\/.*\Z/

end