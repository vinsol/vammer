class Comment < ActiveRecord::Base
  #FIX: Spacing issue
  include SimpleHashtag::Hashtaggable
  hashtaggable_attribute :content
  has_many :document_files, as: :attachment, dependent: :destroy
  accepts_nested_attributes_for :document_files, allow_destroy: true
  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likeable, dependent: :destroy

  #FIX: Add validations for user_id, post_id
  validates :content, presence: true

end