class Post < ActiveRecord::Base

  #FIXME_AB: Please confirm with PM about deleting posts and related content
  has_one :document, as: :attachment, dependent: :destroy
  accepts_nested_attributes_for :document
  belongs_to :user
  belongs_to :group

  validates :content, presence: true
  #FIXME_AB: Should we also add validation on user, because there should be no post with out user.

end