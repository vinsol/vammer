require 'rails_helper'

describe Setting do

  it { should have_one :image }
  it { should accept_nested_attributes_for :image }

  # describe '#prevent_to_empty' do
  #   let(:setting) { Setting.create }
  #   it { expect(setting).to receive(:prevent_to_empty) }
  # end

end
