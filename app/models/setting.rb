class Setting < ActiveRecord::Base

  before_save :uploaded_path_url?

  #FIX: Check if this method has been removed on 'develop'
  # yes it was removed in develop

end
