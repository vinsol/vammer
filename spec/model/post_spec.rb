require 'rails_helper'

describe Post do

  it { should have_one :document }
  it { should have_many :comments }
  it { should belong_to :user }
  it { should belong_to :group }
  it { should accept_nested_attributes_for :comments }
  it { should accept_nested_attributes_for :document }
  it { should validate_presence_of :content }

end
