class Comment < ActiveRecord::Base

  include SimpleHashtag::Hashtaggable

  hashtaggable_attribute :content

  has_many :comment_documents, as: :attachable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  #FIXME_AB: no inverse_of?
  belongs_to :user
  belongs_to :post

  accepts_nested_attributes_for :comment_documents

  #FIXME_AB: everywhere validations should be on user, post. not on user_id post_id, for better error messages.
  validates :content, :user_id, :post_id, presence: true

end