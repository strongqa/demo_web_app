require 'rails_helper'

RSpec.describe 'API V1 Auth', type: :request do
  let!(:users) { create_list(:user, 10) }
  it 'should not allow access via http' do
    https!
    get '/api/v1/users'
    expect(response.body).to eq("HTTP Token: Access denied.\n")
  end
end
