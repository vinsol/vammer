class Setting < ActiveRecord::Base

  has_one :image, as: :attachment, dependent: :destroy
  accepts_nested_attributes_for :image



end
