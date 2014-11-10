require 'rails_helper'

describe Group do

  describe '#add_creator_to_member' do
    let(:user) { create(:user, :current) }
    let(:group) { user.owned_groups.new(name: 'ruby', description: 'nice') }
    it 'should create a member' do
      group.send(:add_creator_to_member)
      expect(group.creator).to equal(group.members.first)
    end
  end

  it { should have_many(:groups_members) }
  it { should have_many(:members).through(:groups_members) }
  it { should have_many(:posts).dependent(:destroy) }
  it { should belong_to(:creator) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }

end
