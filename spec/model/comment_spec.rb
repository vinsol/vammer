require 'rails_helper'

describe Comment do

  #FIX: Group similar rspecs together e.g. associations, validations, instance methods, private methods, class methods, scopes, etc.
  it { should have_many(:document_files).dependent(:destroy) }
  it { should have_many(:likes).dependent(:destroy) }
  it { should belong_to :user }
  it { should belong_to :post }
  it { should accept_nested_attributes_for :document_files }
  it { should validate_presence_of :content}

end
