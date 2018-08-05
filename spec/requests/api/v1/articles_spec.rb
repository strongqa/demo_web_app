require 'rails_helper'

RSpec.describe 'API V1 Articles', type: :request do
  describe 'GET /api/v1/articles' do
    let!(:articles) { create_list(:article, 10) }
    before { get '/api/v1/articles', headers: auth_headers }

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'returns the list of articles' do
      expect(json.map { |x| x['id'] }).to eq [*1..10]
    end
  end

  describe 'GET /api/v1/articles/id' do
    let!(:articles) { create_list(:article, 5) }
    context 'existing article' do
      before { get '/api/v1/articles/3', headers: auth_headers }

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'returns existing article with specified id' do
        expect(json['id']).to eq 3
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
        expect do
          post '/api/v1/articles',
               params: { article: { title: 'Title-1-', text: 'Test', category_id: category.id } },
               headers: auth_headers
        end.to change(Article, :count).by(1)
      end

      it 'returns a created status' do
        post '/api/v1/articles',
             params: { article: { title: 'Title-1-', text: 'Test', category_id: category.id } },
             headers: auth_headers
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      before do
        post '/api/v1/articles',
             params: { article: { title: '', text: 'Test', category_id: '112' } },
             headers: auth_headers
      end

      it 'returns caught errors' do
        expect(json['errors']).to eq('category' => ['must exist'], 'title' => ["can't be blank"])
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /api/v1/articles/id' do
    let!(:article) { create(:article, title: 'Old Name') }

    context 'with valid attributes' do
      before { put "/api/v1/articles/#{article.id}", params: { article: { title: 'New name' } }, headers: auth_headers }

      it 'updates the record in the database' do
        expect(json['title']).to eq 'New name'
        expect(Article.find(article.id).title).to eq 'New name'
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end
    end

    context 'with invalid attributes' do
      before { put "/api/v1/articles/#{article.id}", params: { article: { title: '' } }, headers: auth_headers }

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not update the record in the database' do
        expect(article.reload.title).to eq article.title
      end

      it 'returns caught errors' do
        expect(json['errors']).to eq('title' => ["can't be blank"])
      end
    end
  end

  describe 'DELETE /api/v1/articles/id' do
    let!(:article) { create(:article) }

    it 'deletes the record from the database' do
      expect do
        delete "/api/v1/articles/#{article.id}",
               headers: auth_headers
      end.to change(Article, :count).by(-1)
    end

    it 'returns a no content response' do
      delete "/api/v1/articles/#{article.id}",
             headers: auth_headers
      expect(response).to have_http_status(:no_content)
    end
  end
end
