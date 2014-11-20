class Like < ActiveRecord::Base

  belongs_to :user
  belongs_to :likeable, polymorphic: true

  #FIX: Use new syntax DONE
  validates :user_id, uniqueness: { scope: [:likeable_id, :likeable_type] }

  #FIX: Add validations for user_id, likeable_id, likeable_type

end