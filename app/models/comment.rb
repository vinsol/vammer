class Comment < ActiveRecord::Base

  has_many :document_files, as: :attachment, dependent: :destroy
  accepts_nested_attributes_for :document_files, allow_destroy: true
  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likeable, dependent: :destroy

  validates :content, presence: true

end