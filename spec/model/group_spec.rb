require 'rails_helper'

describe Group do

  describe '#add_creator_to_member' do
    let(:user) { create(:user, :current) }
    #FIX: Create group using factory. You may have to define creator association in group factory
    let(:group) { user.owned_groups.new(name: 'ruby', description: 'nice') }
    it 'should create a member' do
      #FIX: Do not explicitly call this method. Just create the group and check if user is now a member of it
      group.send(:add_creator_to_member)
      #FIX: Below statement can be written as this:
      #   expect( group.members ).to include user
      expect(group.creator).to equal(group.members.first)
    end
  end

  it { should have_many(:groups_members) }
  it { should have_many(:members).through(:groups_members) }
  it { should have_many(:posts).dependent(:destroy) }
  it { should belong_to(:creator) }
  it { should validate_presence_of(:name) }
  #FIX: Add rspec for all validations on name
  it { should validate_presence_of(:description) }

  #FIX: Add rspecs for callbacks

end
