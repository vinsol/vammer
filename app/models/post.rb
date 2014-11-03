class Post < ActiveRecord::Base

  has_one :attachment, as: :attachment, dependent: :destroy

  accepts_nested_attributes_for :attachment

  belongs_to :user

  belongs_to :group

end