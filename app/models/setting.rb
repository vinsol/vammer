class Setting < ActiveRecord::Base

  has_one :image, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :image

  #FIX: Rename #prevent_destroy_last_record
  before_destroy :prevent_to_empty

  #FIX: Should be private
    def prevent_to_empty
      #FIX: Modify condition to Setting.count > 1
      Setting.count != 1
    end

end
