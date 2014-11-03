class Post < ActiveRecord::Base

  has_one :upload, as: :attachment, dependent: :destroy

  accepts_nested_attributes_for :upload

  belongs_to :user

  belongs_to :group

end