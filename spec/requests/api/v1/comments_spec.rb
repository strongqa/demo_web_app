require 'rails_helper'

RSpec.describe 'Commentss', type: :request do
  describe 'GET #index' do
    # before { get '/api/v1/users', headers: { 'Accept': 'application/vnd' } }
    it 'should not allow access via http' do
      https!
      get '/api/v1/users'
      expect(response.body).to eq("HTTP Token: Access denied.\n")
    end

    it 'returns a successful response' do
      get '/articles'
      p response.body
      expect(response).to be_successful
    end
  end
end
