require 'rails_helper'

describe Group do

  describe '#add_creator_to_member' do
    let(:user) { create(:user) }
    #FIX: Create group using factory. You may have to define creator association in group factory
    let(:group) { user.owned_groups.create(name: 'ruby', description: 'nice') }
    it 'should create a member' do
      expect( group.members ).to include user
    end
  end

  it { should have_many(:memberships) }
  it { should have_many(:members).through(:memberships) }
  it { should have_many(:posts).dependent(:destroy) }
  it { should belong_to(:creator) }
  it { should validate_presence_of(:name) }
  # it { should validate_uniqueness_of(:name).at_most(255) }
  #FIX: Add rspec for all validations on name
  it { should validate_presence_of(:description) }

  #FIX: Add rspecs for callbacks

end
