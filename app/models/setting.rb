class Setting < ActiveRecord::Base

  has_one :image, as: :attachment, dependent: :destroy
  accepts_nested_attributes_for :image

  #FIX: Add a callback to prevent destruction of last record in settings table

end
