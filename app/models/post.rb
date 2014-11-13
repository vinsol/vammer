class Post < ActiveRecord::Base
  include SimpleHashtag::Hashtaggable
  hashtaggable_attribute :content
  has_many :documents, as: :attachment, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  accepts_nested_attributes_for :documents, allow_destroy: true
  belongs_to :user
  belongs_to :group
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments

  validates :content, presence: true

end