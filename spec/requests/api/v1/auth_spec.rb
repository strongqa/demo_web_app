require 'rails_helper'

RSpec.describe 'API V1 Auth' do
  let!(:users) { create_list(:user, 10) }

  it 'does not allow access without authentication token' do
    get '/api/v1/users'
    expect(response.body).to eq("HTTP Token: Access denied.\n")
  end
end
