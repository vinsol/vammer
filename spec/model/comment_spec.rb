require 'rails_helper'

describe Comment do

  it { should have_many(:document_files).dependent(:destroy) }
  it { should belong_to :user }
  it { should belong_to :post }
  it { should accept_nested_attributes_for :document_files }
  it { should validate_presence_of :content}

end
