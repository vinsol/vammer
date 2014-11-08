require 'rails_helper'

describe Setting do

  it { should have_one :image }
  it { should accept_nested_attributes_for :image }

end
