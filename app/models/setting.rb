class Setting < ActiveRecord::Base

  # fix- No need for this method. Validation for image extension can be added when implementing Paperclip/Carrierwave
  before_save :uploaded_path_url?

  def uploaded_path_url?
    if value.split('.').last == 'png'
      true
    else
      errors.add(:value, "not valid only .png file will be accepted")
      false
    end
  end

end
