require 'rails_helper'

describe GroupsMember do

  it { should belong_to :user }
  it { should belong_to :group }
  it { should validate_uniqueness_of(:user_id).scoped_to(:group_id) }

end

