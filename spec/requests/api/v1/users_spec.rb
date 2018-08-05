require 'rails_helper'

RSpec.describe 'API V1 Users', type: :request do
  describe 'GET /api/v1/users' do
    let!(:users) { create_list(:user, 10) }
    before { get '/api/v1/users', headers: auth_headers }

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'returns the list of users' do
      expect(json.map { |x| x['id'] }).to eq [*1..10]
    end
  end

  describe 'GET /api/v1/users/id' do
    let!(:users) { create_list(:user, 5) }
    context 'existing user' do
      before { get '/api/v1/users/3', headers: auth_headers }

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'returns existing user with specified id' do
        expect(json['id']).to eq 3
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
        expect do
          post '/api/v1/users', params: { user: attributes_for(:user) }, headers: auth_headers
        end.to change(User, :count).by(1)
      end

      it 'returns a created status' do
        post '/api/v1/users', params: { user: attributes_for(:user) }, headers: auth_headers
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      before do
        post '/api/v1/users',
             params: { user: { email: '', name: 'Test', password: '112', is_admin: false } },
             headers: auth_headers
      end

      it 'returns caught errors' do
        expect(json['errors']).to eq('email' => ["can't be blank"],
                                     'password' => ['is too short (minimum is 8 characters)'])
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /api/v1/users/id' do
    let!(:user) { create(:user, name: 'Old Name') }

    context 'with valid attributes' do
      before { put "/api/v1/users/#{user.id}", params: { user: { name: 'New name' } }, headers: auth_headers }

      it 'updates the record in the database' do
        expect(json['name']).to eq 'New name'
        expect(User.find(user.id).name).to eq 'New name'
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end
    end

    context 'with invalid attributes' do
      before { put "/api/v1/users/#{user.id}", params: { user: { email: '' } }, headers: auth_headers }

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not update the record in the database' do
        expect(user.reload.email).to eq user.email
      end

      it 'returns caught errors' do
        expect(json['errors']).to eq('email' => ["can't be blank"])
      end
    end
  end

  describe 'DELETE /api/v1/users/id' do
    let!(:user) { create(:user) }

    it 'deletes the record from the database' do
      expect do
        delete "/api/v1/users/#{user.id}",
               headers: auth_headers
      end.to change(User, :count).by(-1)
    end

    it 'returns a no content response' do
      delete "/api/v1/users/#{user.id}",
             headers: auth_headers
      expect(response).to have_http_status(:no_content)
    end
  end
end
