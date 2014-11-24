require 'rails_helper'

describe Comment do

  #FIX: Group similar rspecs together e.g. associations, validations, instance methods, private methods, class methods, scopes, etc.
  describe 'associations' do
    it { should have_many(:comment_documents).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }

    it { should belong_to :user }
    it { should belong_to :post }

    it { should accept_nested_attributes_for :comment_documents }
  end

  describe 'validations' do
    it { should validate_presence_of :content}
    it { should validate_presence_of :user_id}
    it { should validate_presence_of :post_id}
  end

end
