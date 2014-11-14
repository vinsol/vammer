class Post < ActiveRecord::Base

  #FIXME_AB: Please confirm with PM about deleting posts and related content
  has_one :document, as: :attachment, dependent: :destroy
  accepts_nested_attributes_for :document
  belongs_to :user
  belongs_to :group

  #FIX: Can be written in one line
  validates :content, presence: true
  validates :user_id, presence: true

end