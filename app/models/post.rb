class Post < ActiveRecord::Base

  include SimpleHashtag::Hashtaggable

  hashtaggable_attribute :content

  has_many :post_documents, as: :attachable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, dependent: :destroy

  belongs_to :user
  belongs_to :group

  #FIX: Do we need allow_destrot here?
  accepts_nested_attributes_for :post_documents, allow_destroy: true
  accepts_nested_attributes_for :comments

  #FIXME_AB: You should validate user not user_id. Error would come on user_id not on user
  validates :content, :user_id, presence: true

end