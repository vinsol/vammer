class Post < ActiveRecord::Base

  has_one :document, as: :attachment, dependent: :destroy
  accepts_nested_attributes_for :document
  belongs_to :user
  belongs_to :group
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments

  validates :content, presence: true

end