require 'rails_helper'

RSpec.describe 'API V1 Comments', type: :request do
  let!(:article) { create(:article) }
  let!(:user) { create(:user) }

  describe 'GET /api/v1/articles/article_id/comments' do
    let!(:comments) { create_list(:comment, 10, article: article, user: user) }
    before { get "/api/v1/articles/#{article.id}/comments", headers: auth_headers }

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'returns the list of comments' do
      expect(json.map { |x| x['id'] }).to eq [*1..10]
    end
  end

  describe 'GET /api/v1/articles/article_id/comments/id' do
    let!(:comments) { create_list(:comment, 5, article: article, user: user) }
    context 'existing comment' do
      before { get "/api/v1/articles/#{article.id}/comments/3", headers: auth_headers }

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'returns existing comment with specified id' do
        expect(json['id']).to eq 3
      end
    end

    context 'not existing comment' do
      it 'raises an error' do
        assert_raises(ActiveRecord::RecordNotFound) do
          get "/api/v1/articles/#{article.id}/comments/1234", headers: auth_headers
        end
      end
    end
  end

  describe 'POST /api/v1/articles/article_id/comments' do
    context 'with valid attributes' do
      it 'creates the record in the database' do
        expect do
          post "/api/v1/articles/#{article.id}/comments",
               params: { comment: attributes_for(:comment, article: article, user_id: user.id) },
               headers: auth_headers
        end.to change(Comment, :count).by(1)
      end

      it 'returns a created status' do
        post "/api/v1/articles/#{article.id}/comments",
             params: { comment: attributes_for(:comment, article: article, user_id: user.id) },
             headers: auth_headers
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      before do
        post "/api/v1/articles/#{article.id}/comments",
             params: { comment: { body: '', user_id: 'T' } },
             headers: auth_headers
      end

      it 'returns caught errors' do
        expect(json['errors']).to eq('user' => ['must exist'], 'body' => ["can't be blank"])
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /api/v1/articles/article_id/comments/id' do
    let!(:comment) { create(:comment, body: 'Old Comment', article: article, user: user) }

    context 'with valid attributes' do
      before do
        put "/api/v1/articles/#{article.id}/comments/#{comment.id}",
            params: { comment: { body: 'New comment' } },
            headers: auth_headers
      end

      it 'updates the record in the database' do
        expect(json['body']).to eq 'New comment'
        expect(Comment.find(comment.id).body).to eq 'New comment'
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end
    end

    context 'with invalid attributes' do
      before do
        put "/api/v1/articles/#{article.id}/comments/#{comment.id}",
            params: { comment: { body: '' } },
            headers: auth_headers
      end

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not update the record in the database' do
        expect(comment.reload.body).to eq comment.body
      end

      it 'returns caught errors' do
        expect(json['errors']).to eq('body' => ["can't be blank"])
      end
    end
  end

  describe 'DELETE /api/v1/articles/article_id/comments/id' do
    let!(:comment) { create(:comment, article: article, user: user) }

    it 'deletes the record from the database' do
      expect do
        delete "/api/v1/articles/#{article.id}/comments/#{comment.id}",
               headers: auth_headers
      end.to change(Comment, :count).by(-1)
    end

    it 'returns a no content response' do
      delete "/api/v1/articles/#{article.id}/comments/#{comment.id}",
             headers: auth_headers
      expect(response).to have_http_status(:no_content)
    end
  end
end
