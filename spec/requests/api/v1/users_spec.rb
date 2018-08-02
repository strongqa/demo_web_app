require 'rails_helper'

RSpec.describe 'Users', type: :request do # rubocop:disable Metrics/BlockLength
  headers = { 'Authorization': "Token token=#{ENV['HOWITZER_TOKEN']}" }

  describe 'GET #index' do
    let!(:users) { create_list(:user, 3) }
    before { get '/api/v1/users', headers: headers }

    it 'returns a successful response' do
      expect(response).to be_successful
    end
    it 'returns the list of users' do
      p :users
      # p response.body[:id]
      expect(response.body).to eq :users
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get user_path create(:user)
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get new_user_path
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      get edit_user_path create(:user)
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates the record in the database' do
        expect do
          post users_path, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(1)
      end

      it 'redirects to users#show' do
        post users_path, params: { user: attributes_for(:user) }
        expect(response).to redirect_to user_url(User.first)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a record in the database' do
        expect do
          post users_path, params: { user: attributes_for(:user, :invalid) }
        end.to_not change(User, :count)
      end

      it 'returns a successful response' do
        post users_path, params: { user: attributes_for(:user, :invalid) }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH #update' do
    let!(:user) { create(:user, email: 'john@example.com') }

    context 'with valid attributes' do
      it 'updates the record in the database' do
        patch user_path user, params: { user: attributes_for(:user, email: 'jane@example.com') }
        expect(user.reload.email).to eq 'jane@example.com'
      end

      it 'redirects to users#show' do
        patch user_path user, params: { user: attributes_for(:user) }
        expect(response).to redirect_to user
      end
    end

    context 'with invalid attributes' do
      it 'does not update the record in the database' do
        patch user_path user, params: { user: attributes_for(:user, :invalid) }
        expect(user.reload.email).to eq 'john@example.com'
      end

      it 'returns a successful response' do
        patch user_path user, params: { user: attributes_for(:user, :invalid) }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { build(:user) }

    it 'deletes the record from the database' do
      expect do
        delete user_path user
      end.to change(User, :count).by(-1)
    end

    it 'redirects to users#index' do
      delete user_path :user
      expect(response).to redirect_to users_url
    end
  end
end
