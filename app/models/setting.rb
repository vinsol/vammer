class Setting < ActiveRecord::Base

  has_one :image, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :image

  before_destroy :prevent_to_empty

    def prevent_to_empty
      Setting.count != 1
    end

end
