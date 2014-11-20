require 'rails_helper'
describe UsersController, type: :controller do
  
  describe 'GET #edit' do
    let(:user) { create(:user) }
    subject do
      sign_in(user, @user)
      get 'edit', id: user.id
    end

    it 'renders :edit view' do
      expect(subject).to render_template('edit')
    end

  end

end