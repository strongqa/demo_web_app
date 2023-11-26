require 'rails_helper'

RSpec.describe 'API V1 Categories' do
  describe 'GET /api/v1/categories' do
    let!(:categories) { create_list(:category, 10) }

    before { get '/api/v1/categories', headers: auth_headers }

    it 'returns HTTP status 200' do
      expect(response).to have_http_status :ok
    end

    it 'returns the list of categories' do
      expect(response_json.size).to eq(10)
    end
  end

  describe 'GET /api/v1/categories/id' do
    let!(:category1) { create(:category) }
    let!(:category2) { create(:category) }
    let!(:category3) { create(:category) }

    context 'existing category' do
      before { get "/api/v1/categories/#{category2.id}", headers: auth_headers }

      it 'returns HTTP status 200' do
        expect(response).to have_http_status :ok
      end

      it 'returns existing category with specified id' do
        expect(response_json['id']).to eq category2.id
      end
    end

    context 'not existing category' do
      it 'raises an error' do
        assert_raises(ActiveRecord::RecordNotFound) do
          get '/api/v1/categories/1234', headers: auth_headers
        end
      end
    end
  end

  describe 'POST /api/v1/categories' do
    context 'with valid attributes' do
      it 'creates the record in the database' do
        post '/api/v1/categories', params: { category: attributes_for(:category) }, headers: auth_headers
        expect(Category).to exist(response_json['id'])
      end

      it 'returns a created status' do
        post '/api/v1/categories', params: { category: attributes_for(:category) }, headers: auth_headers
        expect(response).to have_http_status :created
      end
    end

    context 'with invalid attributes' do
      before do
        post '/api/v1/categories',
             params: { category: { name: '' } },
             headers: auth_headers
      end

      it 'returns caught errors' do
        expect(response_json['errors']).to eq('name' => ["can't be blank"])
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe 'PUT /api/v1/categories/id' do
    let!(:category) { create(:category, name: 'Old Name') }

    context 'with valid attributes' do
      before do
        put "/api/v1/categories/#{category.id}", params: { category: { name: 'New name' } }, headers: auth_headers
      end

      it 'updates the record in the database' do
        expect(response_json['name']).to eq 'New name'
        expect(category.reload.name).to eq 'New name'
      end

      it 'returns HTTP status 200' do
        expect(response).to have_http_status :ok
      end
    end

    context 'with invalid attributes' do
      before { put "/api/v1/categories/#{category.id}", params: { category: { name: '' } }, headers: auth_headers }

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'does not update the record in the database' do
        expect(category.reload.name).to eq category.name
      end

      it 'returns caught errors' do
        expect(response_json['errors']).to eq('name' => ["can't be blank"])
      end
    end
  end

  describe 'DELETE /api/v1/categories/id' do
    let!(:category) { create(:category) }

    it 'deletes the record from the database' do
      delete "/api/v1/categories/#{category.id}", headers: auth_headers
      expect(Category).not_to exist(category.id)
    end

    it 'returns a no content response' do
      delete "/api/v1/categories/#{category.id}", headers: auth_headers
      expect(response).to have_http_status :no_content
    end
  end
end
