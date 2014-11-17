#FIX: Spacing issue
class Post < ActiveRecord::Base
  include SimpleHashtag::Hashtaggable
  hashtaggable_attribute :content

  #FIX: Group similar logic together
  has_many :documents, as: :attachment, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  accepts_nested_attributes_for :documents, allow_destroy: true
  #FIXME_AB: Please confirm with PM about deleting posts and related content
  belongs_to :user
  belongs_to :group
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments

  validates :content, presence: true
  validates :user_id, presence: true
  #FIXME_AB: Should we also add validation on user, because there should be no post with out user. -DONE

end