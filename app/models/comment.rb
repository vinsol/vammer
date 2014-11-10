class Comment < ActiveRecord::Base

  has_many :document_files, as: :attachment, dependent: :destroy
  accepts_nested_attributes_for :document_files, allow_destroy: true
  belongs_to :user
  belongs_to :post

  validates :content, presence: true

end