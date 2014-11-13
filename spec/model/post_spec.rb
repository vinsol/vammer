require 'rails_helper'

describe Post do

  it { should have_many :documents }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many :comments }
  it { should belong_to :user }
  it { should belong_to :group }
  it { should accept_nested_attributes_for :comments }
  it { should accept_nested_attributes_for :documents }
  it { should validate_presence_of :content }
  it { should validate_presence_of :user_id }

end
