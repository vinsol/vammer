class Setting < ActiveRecord::Base

  before_save :uploaded_path_url?

  def uploaded_path_url?
    if value.split('.').last == 'jpg'
      true
    else
      errors.add(:value, "not valid only .png file will be accepted")
      false
    end
  end

end
