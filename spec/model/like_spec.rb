require 'rails_helper'

describe Like do

  it { should belong_to :user }
  it { should belong_to :likeable }

  it { should validate_uniqueness_of(:user_id).scoped_to([:likeable_id, :likeable_type]) }

end
