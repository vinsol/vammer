require 'rails_helper'

describe User do

  #FIX: Add rspces for constants too

  describe '#email_matches_company_domain' do

    let(:user) { build(:user) }

    context 'when matches' do
      it do
        user.valid?
        expect(user.errors).not_to include ("domain does not match with #{COMPANY['domain']}")
      end
    end

    context 'when not matches' do
      it do
        user.email = 'sawan@gmail.com'
        user.valid?
        expect(user.errors[:email]).to include ("domain does not match with #{COMPANY['domain']}")
      end
    end

  end

  describe '#search_extraneous' do
    let(:first_user) { create(:user, :with_group) }
    let(:second_user) { create(:user) }

    context 'when user has groups' do
      it do
        #FIX: Use let and factories to build groups
        # my_group = user.owned_groups.create(name: 'my', description: 'my group')
        # other_group = admin.owned_groups.create(name: 'other', description: 'other group')
        #FIX: No need to pluck id here. Just check count of returned arel and other group is included in arel
        # expect(user.search_extraneous.pluck(:id)).to eql (Group.where(id: other_group.id).pluck(:id))
        expect(first_user.search_extraneous).to include (second_user.groups)
      end
    end

  end

  describe '#active_for_authentication?' do
    let(:user) { build(:user) }
    let(:disabled_user) { build(:user, :disabled) }
    context 'when confirmed' do
      it do
        expect(user.active_for_authentication?).to equal true
      end
    end
    context 'when not confirmed' do
      it { expect(disabled_user.active_for_authentication?).to_not equal true }
    end
  end

  describe 'validate_format' do
    let(:user) { build(:user) }
    context '' do
      it do
        user.name = 'sawan'
        user.valid?
        expect(user.errors[:name]).not_to include 'only letters'
      end
      it do
        user.name = 'saw an'
        user.valid?
        expect(user.errors[:name]).not_to include 'only letters'
      end
      it do
        user.name = 'sawa_n'
        user.valid?
        expect(user.errors[:name]).to include 'only letters'
      end
      it do
        user.name = '   '
        user.valid?
        expect(user.errors[:name]).not_to include 'only letters'
      end
      it do
        user.name = ''
        user.valid?
        expect(user.errors[:name]).to include 'only letters'
      end
      it do
        user.name = '  y  '
        user.valid?
        expect(user.errors[:name]).not_to include 'only letters'
      end
      it do
        user.name = '67'
        user.valid?
        expect(user.errors[:name]).to include 'only letters'
      end
    end
  end

  describe 'include devise' do

    let(:user) { build(:user) }

    describe 'database_authenticatable' do
      it { expect(user).to be_kind_of (Devise::Models::DatabaseAuthenticatable) }
    end

    describe 'registerable' do
      it { expect(user).to be_kind_of (Devise::Models::Registerable) }
    end

    describe 'recoverable' do
      it { expect(user).to be_kind_of (Devise::Models::Recoverable) }
    end

    describe 'rememberable' do
      it { expect(user).to be_kind_of (Devise::Models::Rememberable) }
    end

    describe 'validatable' do
      it { expect(user).to be_kind_of (Devise::Models::Validatable) }
    end

    describe 'confirmable' do
      it { expect(user).to be_kind_of (Devise::Models::Confirmable) }
    end

  end

  describe 'enabled scope' do

    describe 'when user is enabled' do
      let(:user) { create(:user) }
      it { expect(User.enabled).to eq [user] }
    end

    describe 'when user is not enabled' do
      let(:disabled_user) { create(:user, :disabled) }
      it { expect(User.enabled).not_to eq [disabled_user] }
    end

  end

  describe '.sort' do

    let(:user) { create(:user) }
    let(:second_user) { create(:user) }

    describe 'when column is name' do

      describe 'when ascending' do
        it do
          second_user.name = 'amit'
          second_user.save
          expect(User.sort(User.all, :name, :asc)).to eq [second_user, user]
        end
      end

      describe 'when descending' do
        it do
          second_user.name = 'amit'
          second_user.save
          expect(User.sort(User.all, :name, :desc)).to eq [user, second_user]
        end
      end

    end

    describe 'when column is email' do

      describe 'when ascending' do
        it do
          expect(User.sort(User.all, :email, :asc)).to eq [second_user, user]
        end
      end

      describe 'when descending' do
        it do
          expect(User.sort(User.all, :email, :asc)).to eq [user, second_user]
        end
      end

    end

  end

  describe 'associations' do
    it { should have_one(:image).dependent(:destroy) }
    it { should have_many(:likes) }
    it { should have_many(:memberships).dependent(:destroy) }
    it { should have_many(:groups).through(:memberships) }
    it { should have_many(:owned_groups).class_name(Group).with_foreign_key(:creator_id) }
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should accept_nested_attributes_for :image }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:name).is_at_most(255) }
  end

end
