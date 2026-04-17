require 'swagger_helper'

RSpec.describe 'Authentication', type: :request do
  path '/api/v1/auth/sign_up' do
    post 'Register a new parent account' do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, example: 'parent@example.com' },
              password: { type: :string, example: 'password123' },
              password_confirmation: { type: :string, example: 'password123' }
            },
            required: %w[email password password_confirmation]
          }
        },
        required: %w[user]
      }

      response '201', 'account created' do
        schema type: :object,
               properties: {
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     email: { type: :string }
                   }
                 }
               }

        let(:body) { { user: { email: 'parent@example.com', password: 'password123', password_confirmation: 'password123' } } }
        run_test!
      end

      response '422', 'invalid parameters' do
        schema type: :object,
               properties: {
                 errors: { type: :array, items: { type: :string } }
               }

        let(:body) { { user: { email: '', password: 'x', password_confirmation: '' } } }
        run_test!
      end
    end
  end

  path '/api/v1/auth/sign_in' do
    post 'Sign in' do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, example: 'parent@example.com' },
              password: { type: :string, example: 'password123' }
            },
            required: %w[email password]
          }
        },
        required: %w[user]
      }

      response '200', 'signed in — JWT returned in Authorization header' do
        schema type: :object,
               properties: {
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     email: { type: :string }
                   }
                 }
               }

        let(:existing_user) { create(:user, email: 'parent@example.com', password: 'password123') }
        let(:body) { { user: { email: existing_user.email, password: 'password123' } } }

        before { existing_user }

        run_test!
      end

      response '401', 'invalid credentials' do
        let(:body) { { user: { email: 'nobody@example.com', password: 'wrongpassword' } } }
        run_test!
      end
    end
  end

  path '/api/v1/auth/sign_out' do
    delete 'Sign out' do
      tags 'Authentication'
      produces 'application/json'
      security [ bearer_auth: [] ]

      parameter name: 'Authorization', in: :header, type: :string, required: true,
                description: 'Bearer <token>'

      response '200', 'signed out' do
        schema type: :object,
               properties: {
                 message: { type: :string, example: 'Signed out successfully.' }
               }

        let(:user) { create(:user) }
        let(:Authorization) do
          post '/api/v1/auth/sign_in',
            params: { user: { email: user.email, password: 'password123' } }.to_json,
            headers: { 'Content-Type' => 'application/json' }
          response.headers['Authorization']
        end

        run_test!
      end

      response '401', 'missing or invalid token' do
        let(:Authorization) { 'Bearer invalidtoken' }
        run_test!
      end
    end
  end
end
