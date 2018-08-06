require 'rails_helper'

RSpec.describe 'API V1 Users', type: :request do
  describe 'GET /api/v1/users' do
    let!(:users) { create_list(:user, 10) }
    before { get '/api/v1/users', headers: auth_headers }

    it 'returns HTTP status 200' do
      expect(response).to have_http_status 200
    end

    it 'returns the list of users' do
      expect(response_json.size).to eq(10)
    end
  end

  describe 'GET /api/v1/users/id' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:user3) { create(:user) }
    context 'existing user' do
      before { get "/api/v1/users/#{user2.id}", headers: auth_headers }

      it 'returns HTTP status 200' do
        expect(response).to have_http_status 200
      end

      it 'returns existing user with specified id' do
        expect(response_json['id']).to eq user2.id
      end
    end

    context 'not existing user' do
      it 'raises an error' do
        assert_raises(ActiveRecord::RecordNotFound) do
          get '/api/v1/users/1234', headers: auth_headers
        end
      end
    end
  end

  describe 'POST /api/v1/users' do
    context 'with valid attributes' do
      it 'creates the record in the database' do
        post '/api/v1/users', params: { user: attributes_for(:user) }, headers: auth_headers
        expect(User.exists?(response_json['id'])).to be_truthy
      end

      it 'returns a created status' do
        post '/api/v1/users', params: { user: attributes_for(:user) }, headers: auth_headers
        expect(response).to have_http_status 201
      end
    end

    context 'with invalid attributes' do
      before do
        post '/api/v1/users',
             params: { user: { email: '', name: 'Test', password: '112', is_admin: false } },
             headers: auth_headers
      end

      it 'returns caught errors' do
        expect(response_json['errors']).to eq('email' => ["can't be blank"],
                                              'password' => ['is too short (minimum is 8 characters)'])
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status 422
      end
    end
  end

  describe 'PUT /api/v1/users/id' do
    let!(:user) { create(:user, name: 'Old Name') }

    context 'with valid attributes' do
      before { put "/api/v1/users/#{user.id}", params: { user: { name: 'New name' } }, headers: auth_headers }

      it 'updates the record in the database' do
        expect(response_json['name']).to eq 'New name'
        expect(user.reload.name).to eq 'New name'
      end

      it 'returns HTTP status 200' do
        expect(response).to have_http_status 200
      end
    end

    context 'with invalid attributes' do
      before { put "/api/v1/users/#{user.id}", params: { user: { email: '' } }, headers: auth_headers }

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status 422
      end

      it 'does not update the record in the database' do
        expect(user.reload.email).to eq user.email
      end

      it 'returns caught errors' do
        expect(response_json['errors']).to eq('email' => ["can't be blank"])
      end
    end
  end

  describe 'DELETE /api/v1/users/id' do
    let!(:user) { create(:user) }

    it 'deletes the record from the database' do
      delete "/api/v1/users/#{user.id}", headers: auth_headers
      expect(User.exists?(user.id)).to be_falsey
    end

    it 'returns a no content response' do
      delete "/api/v1/users/#{user.id}",
             headers: auth_headers
      expect(response).to have_http_status 204
    end
  end
end
