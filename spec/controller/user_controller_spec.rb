require 'rails_helper'

describe UsersController, type: :controller do

  let(:user) { mock_model(User, name: 'sawan') }

  before do
    login_user
  end

  describe '#followers' do

    before do
      get :follower, id: user
    end

    it { expect(user).to receive(:followers).exactly(1).times }
    # it { expect(response).to render_template('index') }

  end

  # describe '#following' do

  #   before do
  #     get :following, id: user
  #   end

  #   it { expect(user).to receive(:followed_users).exactly(0).times }
  #   it { expect(response).to render_template('index') }

  # end

  # describe '#mentioned_users' do

  #   before do
  #     get :mentioned_users, name: user.name
  #   end

  #   it do
  #     allow(user).to receive_message_chain(:posts, :order => :ordered_posts).with( created_at: :desc )
  #     expect(user.posts.order(created_at: :desc)).to eq(:ordered_posts)
  #   end
  #   it { expect(controller).to receive(:initialize_comment).exactly(0).times }
  #   it { expect(controller).to receive(:initialize_post).exactly(0).times }
  #   it { expect(response).to render_template('show') }

  # end

  # describe '#mentioned working' do

  #   it 'has a success status' do
  #     xhr :get, :mentioned, term: 'sawan'
  #     expect(response).to have_http_status :success
  #   end

  # end

  # describe '#edit' do

  #   before do
  #     get :edit, id: user
  #   end

  #   it { expect(user).to receive(:build_image).exactly(0).times }
  #   it { expect(user).to receive(:image).exactly(0).times }

  # end

  # describe '#show' do

  #   it { expect(controller).to receive(:initialize_posts_comments).exactly(0).times }

  # end

end