require 'rails_helper'

describe User do

  describe '#email_matches_company_domain' do

    let(:domain) { COMPANY['domain'] }
    let(:user) { create(:user, :current) }

    context 'when matches' do
      it { expect(domain).to eq (user.email.split('@').last) }
    end

  end

  describe '#search_extraneous' do
    let(:user) { create(:user, :current) }
    let(:admin) { create(:user, :admin) }

    context 'when user has groups' do
      it do
        my_group = user.owned_groups.create(name: 'my', description: 'my group')
        other_group = admin.owned_groups.create(name: 'other', description: 'other group')
        expect(user.search_extraneous.pluck(:id)).to eql (Group.where(id: other_group.id).pluck(:id))
      end
    end

    context 'when user has no groups' do
      it do
        other_group = admin.owned_groups.create(name: 'other', description: 'other group')
        expect(user.search_extraneous.pluck(:id)).to eql (Group.where(id: other_group.id).pluck(:id))
      end
    end

  end

  describe '#active_for_authentication?' do
    let(:user) { create(:user, :current) }
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
      REGEX = /\A([a-z]|\s)+\z/i
      it do
        user.name = 'sawan'
        expect(user.name).to match REGEX
      end
      it do
        user.name = 'saw an'
        expect(user.name).to match REGEX
      end
      it do
        user.name = 'sawa_n'
        expect(user.name).not_to match REGEX
      end
      it do
        user.name = '   '
        expect(user.name).to match REGEX
      end
      it do
        user.name = ''
        expect(user.name).not_to match REGEX
      end
      it do
        user.name = '  y  '
        expect(user.name).to match REGEX
      end
      it do
        user.name = '67'
        expect(user.name).not_to match REGEX
      end
    end
  end

  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(255) }
  it { should have_one(:image).dependent(:destroy) }
  it { should have_many(:groups_members).dependent(:destroy) }
  it { should have_many(:likes) }
  it { should have_many(:groups).through(:groups_members) }
  it { should have_many(:owned_groups) }
  it { should have_many(:posts).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should accept_nested_attributes_for :image }

end
