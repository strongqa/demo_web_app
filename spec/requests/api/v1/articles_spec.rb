require 'rails_helper'

RSpec.describe 'API V1 Articles', type: :request do
  describe 'GET /api/v1/articles' do
    let!(:articles) { create_list(:article, 10) }
    before { get '/api/v1/articles', headers: auth_headers }

    it 'returns HTTP status 200' do
      expect(response).to have_http_status 200
    end

    it 'returns the list of articles' do
      expect(response_json.size).to eq(10)
    end
  end

  describe 'GET /api/v1/articles/id' do
    let!(:article1) { create(:article) }
    let!(:article2) { create(:article) }
    let!(:article3) { create(:article) }

    context 'existing article' do
      before { get "/api/v1/articles/#{article2.id}", headers: auth_headers }

      it 'returns HTTP status 200' do
        expect(response).to have_http_status 200
      end

      it 'returns existing article with specified id' do
        expect(response_json['id']).to eq article2.id
      end
    end

    context 'not existing article' do
      it 'raises an error' do
        assert_raises(ActiveRecord::RecordNotFound) do
          get '/api/v1/articles/1234', headers: auth_headers
        end
      end
    end
  end

  describe 'POST /api/v1/articles' do
    context 'with valid attributes' do
      let!(:category) { create(:category) }

      it 'creates the record in the database' do
        post '/api/v1/articles',
             params: { article: attributes_for(:article, category_id: category.id) },
             headers: auth_headers
        expect(Article.exists?(response_json['id'])).to be_truthy
      end

      it 'returns a created status' do
        post '/api/v1/articles',
             params: { article: attributes_for(:article, category_id: category.id) },
             headers: auth_headers
        expect(response).to have_http_status 201
      end
    end

    context 'with invalid attributes' do
      before do
        post '/api/v1/articles',
             params: { article: { title: '', text: 'Test' } },
             headers: auth_headers
      end

      it 'returns caught errors' do
        expect(response_json['errors']).to eq('category' => ['must exist'], 'title' => ["can't be blank"])
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status 422
      end
    end
  end

  describe 'PUT /api/v1/articles/id' do
    let!(:article) { create(:article, title: 'Old Name') }

    context 'with valid attributes' do
      before { put "/api/v1/articles/#{article.id}", params: { article: { title: 'New name' } }, headers: auth_headers }

      it 'updates the record in the database' do
        expect(response_json['title']).to eq 'New name'
        expect(article.reload.title).to eq 'New name'
      end

      it 'returns HTTP status 200' do
        expect(response).to  have_http_status 200
      end
    end

    context 'with invalid attributes' do
      before { put "/api/v1/articles/#{article.id}", params: { article: { title: '' } }, headers: auth_headers }

      it 'returns an unprocessable entity status' do
        expect(response).to  have_http_status 422
      end

      it 'does not update the record in the database' do
        expect(article.reload.title).to eq article.title
      end

      it 'returns caught errors' do
        expect(response_json['errors']).to eq('title' => ["can't be blank"])
      end
    end
  end

  describe 'DELETE /api/v1/articles/id' do
    let!(:article) { create(:article) }

    it 'deletes the record from the database' do
      delete "/api/v1/articles/#{article.id}", headers: auth_headers
      expect(Article.exists?(article.id)).to be_falsey
    end

    it 'returns a no content response' do
      delete "/api/v1/articles/#{article.id}", headers: auth_headers
      expect(response).to have_http_status 204
    end
  end
end
