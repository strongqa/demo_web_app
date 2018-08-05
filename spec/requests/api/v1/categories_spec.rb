require 'rails_helper'

RSpec.describe 'API V1 Categories', type: :request do
  describe 'GET /api/v1/categories' do
    let!(:categories) { create_list(:category, 10) }
    before { get '/api/v1/categories', headers: auth_headers }

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'returns the list of categories' do
      expect(json.map { |x| x['id'] }).to eq [*1..10]
    end
  end

  describe 'GET /api/v1/categories/id' do
    let!(:categories) { create_list(:category, 5) }
    context 'existing category' do
      before { get '/api/v1/categories/3', headers: auth_headers }

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'returns existing category with specified id' do
        expect(json['id']).to eq 3
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
        expect do
          post '/api/v1/categories', params: { category: attributes_for(:category) }, headers: auth_headers
        end.to change(Category, :count).by(1)
      end

      it 'returns a created status' do
        post '/api/v1/categories', params: { category: attributes_for(:category) }, headers: auth_headers
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      before do
        post '/api/v1/categories',
             params: { category: { name: '' } },
             headers: auth_headers
      end

      it 'returns caught errors' do
        expect(json['errors']).to eq('name' => ["can't be blank"])
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
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
        expect(json['name']).to eq 'New name'
        expect(Category.find(category.id).name).to eq 'New name'
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end
    end

    context 'with invalid attributes' do
      before { put "/api/v1/categories/#{category.id}", params: { category: { name: '' } }, headers: auth_headers }

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not update the record in the database' do
        expect(category.reload.name).to eq category.name
      end

      it 'returns caught errors' do
        expect(json['errors']).to eq('name' => ["can't be blank"])
      end
    end
  end

  describe 'DELETE /api/v1/categories/id' do
    let!(:category) { create(:category) }

    it 'deletes the record from the database' do
      expect do
        delete "/api/v1/categories/#{category.id}",
               headers: auth_headers
      end.to change(Category, :count).by(-1)
    end

    it 'returns a no content response' do
      delete "/api/v1/categories/#{category.id}",
             headers: auth_headers
      expect(response).to have_http_status(:no_content)
    end
  end
end
