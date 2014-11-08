class Comment < ActiveRecord::Base

  has_one :document, as: :attachment, dependent: :destroy
  accepts_nested_attributes_for :document
  belongs_to :user
  belongs_to :post

  validates :content, presence: true

end