#FIX: Spacing issue
class Post < ActiveRecord::Base

  include SimpleHashtag::Hashtaggable
  hashtaggable_attribute :content

  #FIX: Group similar logic together
  has_many :documents, as: :attachment, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :group

  accepts_nested_attributes_for :documents, allow_destroy: true
  accepts_nested_attributes_for :comments
  #FIXME_AB: Please confirm with PM about deleting posts and related content

  #FIX: Can be written in one line
  validates :content, :user_id, presence: true

end