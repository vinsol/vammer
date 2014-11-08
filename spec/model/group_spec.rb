require 'rails_helper'

describe Group do

  it { should have_many(:groups_members) }
  it { should have_many(:members).through(:groups_members) }
  it { should have_many(:posts).dependent(:destroy) }
  it { should belong_to(:creator) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }

end
