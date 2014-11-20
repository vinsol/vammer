require 'rails_helper'

describe User do

  #FIX: Add rspces for constants too
  #FIX: Check rspecs for devise method being used in user model

  describe '#email_matches_company_domain' do

    #FIX: No need to store in a variable
    let(:domain) { COMPANY['domain'] }
    let(:user) { create(:user, :current) }

    #FIX: Do not repeat model logic here.
    #   Build 2 different users, one with correct domain email, other with invalid domain.
    #   Then check errors[:email] after calling #valid? on each

    context 'when matches' do
      it { expect(domain).to eq (user.email.split('@').last) }
    end

  end

  describe '#search_extraneous' do
    let(:user) { create(:user, :current) }
    let(:admin) { create(:user, :admin) }

    context 'when user has groups' do
      it do
        #FIX: Use let and factories to create groups
        my_group = user.owned_groups.create(name: 'my', description: 'my group')
        other_group = admin.owned_groups.create(name: 'other', description: 'other group')
        #FIX: No need to pluck id here. Just check count of returned arel and other group is included in arel
        expect(user.search_extraneous.pluck(:id)).to eql (Group.where(id: other_group.id).pluck(:id))
      end
    end

    #FIX: Not required
    context 'when user has no groups' do
      it do
        other_group = admin.owned_groups.create(name: 'other', description: 'other group')
        expect(user.search_extraneous.pluck(:id)).to eql (Group.where(id: other_group.id).pluck(:id))
      end
    end

  end

  describe '#active_for_authentication?' do
    let(:user) { create(:user, :current) }
    #FIX: Do not check for confirmed/unconfirmed user here. Devise does it for you.
    #   Just check users, who are confirmed && enabled, OR confirmed && disabled
    context 'when confirmed' do
      it do
        user.confirmed_at = Time.current
        expect(user.active_for_authentication?).to equal true
      end
    end
    context 'when not confirmed' do
      it { expect(user.active_for_authentication?).to_not equal true }
    end
  end

  describe 'validate_format' do
    let(:user) { build(:user, :current) }
    context '' do
      #FIX: Remove this
      REGEX = /\A([a-z]|\s)+\z/i
      it do
        #FIX: Why assigning capitalize=
        user.name.capitalize = 'sawan'
        #FIX: Do not match Regex here. Instead assign a name to a user and call valid?
        expect(user.name.capitalize).to match REGEX
      end
      it do
        user.name.capitalize = 'saw an'
        expect(user.name.capitalize).to match REGEX
      end
      it do
        user.name.capitalize = 'sawa_n'
        expect(user.name.capitalize).not_to match REGEX
      end
      it do
        user.name.capitalize = '   '
        expect(user.name.capitalize).to match REGEX
      end
      it do
        user.name.capitalize = ''
        expect(user.name.capitalize).not_to match REGEX
      end
      it do
        user.name.capitalize = '  y  '
        expect(user.name.capitalize).to match REGEX
      end
      it do
        user.name.capitalize = '67'
        expect(user.name.capitalize).not_to match REGEX
      end
    end
  end

  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(255) }
  it { should have_one(:image).dependent(:destroy) }
  it { should have_many(:groups_members).dependent(:destroy) }
  it { should have_many(:likes) }
  it { should have_many(:groups).through(:groups_members) }

  #FIX: Check class name and foreign key
  it { should have_many(:owned_groups) }
  it { should have_many(:posts).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should accept_nested_attributes_for :image }

end
