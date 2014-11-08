require 'rails_helper'

describe Comment do

  it { should have_one(:document).dependent(:destroy) }
  it { should belong_to :user }
  it { should belong_to :post }
  it { should accept_nested_attributes_for :document }
  it { should validate_presence_of :content}

end
