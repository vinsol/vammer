class Post < ActiveRecord::Base

  #FIXME_AB: Please confirm with PM about deleting posts and related content
  has_one :document, as: :attachment
  accepts_nested_attributes_for :document
  belongs_to :user
  belongs_to :group

  validates :content, :user_id, presence: true

end