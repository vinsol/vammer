class Comment < ActiveRecord::Base

  has_many :documents, as: :attachment, dependent: :destroy
  has_many :attach, as: :attachment, class_name: Attachment
  accepts_nested_attributes_for :attach, allow_destroy: true
  belongs_to :user
  belongs_to :post

  validates :content, presence: true

end