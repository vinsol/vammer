class Comment < ActiveRecord::Base

  has_many :documents, as: :attachment, dependent: :destroy
  accepts_nested_attributes_for :documents, allow_destroy: true
  belongs_to :user
  belongs_to :post

  validates :content, presence: true

end