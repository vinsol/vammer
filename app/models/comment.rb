class Comment < ActiveRecord::Base
  #FIX: Spacing issue DONE

  include SimpleHashtag::Hashtaggable
  hashtaggable_attribute :content

  has_many :document_files, as: :attachment, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  belongs_to :user
  belongs_to :post
  accepts_nested_attributes_for :document_files

  #FIX: Add validations for user_id, post_id DONE
  validates :content, :user_id, :post_id, presence: true

end