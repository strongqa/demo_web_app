require 'rails_helper'

RSpec.describe 'Articles', type: :request do # rubocop:disable Metrics/BlockLength
  describe 'GET #index' do
    it 'returns a successful response' do
      get '/articles'
      p response.body
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get article_path create(:article)
      expect(response).to be_successful
      p response.body
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
