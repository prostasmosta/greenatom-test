require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'POST /users' do
    let(:valid_attributes) do
      {
        user: {
          name: 'John',
          email: 'john@example.com',
          password: 'password123',
          password_confirmation: 'password123',
          passport_data: { number: '12345', issued_by: 'Moscow', issued_at: '2023-01-01' }
        }
      }
    end

    it 'creates a new user' do
      post '/users', params: valid_attributes
      expect(response).to have_http_status(:created)
      expect(User.count).to eq(1)
    end

    it 'returns JSON with user data and auth token in headers' do
      post '/users', params: valid_attributes
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['name']).to eq('John')
      expect(response.headers['Authorization']).to be_present
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { user: { name: 'John' } } }

      it 'does not create a new user' do
        post '/users', params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(User.count).to eq(0)
      end
    end
  end

  describe 'GET /users' do
    it 'returns a list of users' do
      users = create_list(:user, 5)

      headers = {
        'Authorization' => "Bearer #{users.first.auth_token}"
      }

      get '/users', headers: headers
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(5)
    end
  end

  describe 'GET /users/:id' do
    let(:user) { create(:user) }

    it 'returns a single user' do
      headers = {
        'Authorization' => "Bearer #{user.auth_token}"
      }

      get "/users/#{user.id}", headers: headers
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['name']).to eq(user.name)
    end
  end
end
