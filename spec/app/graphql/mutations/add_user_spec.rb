require 'rails_helper'

describe 'Add User mutation', type: :request do
  include_context 'with GraphQL Client'

  context 'when a new user is created' do
    let(:user) { build(:user) }
    let(:query) do
      <<-GRAPHQL
      mutation addUser($email: String!, $password: String!) {
        addUser(input: { email: $email, password: $password }) {
          errors
          user {
            id
            email
          }
        }
      }
      GRAPHQL
    end

    it 'creates an user with the correct data' do
      expect { post_graph(query, { email: user.email, password: user.password }) }.to change(User, :count).by(1)

      created_user = User.last

      expect(created_user.email).to eq(user.email)
      expect(created_user.authenticate(user.password)).to eq(created_user)
    end
  end

  context 'when email is already in use' do
    let!(:user) { create(:user) }
    let(:failed_user) { build(:user, email: user.email) }
    let(:query) do
      <<-GRAPHQL
      mutation addUser($email: String!, $password: String!) {
        addUser(input: { email: $email, password: $password }) {
          errors
          user {
            id
            email
          }
        }
      }
      GRAPHQL
    end

    it 'does not create a new user with the same email' do
      expect do
        post_graph(query, { email: failed_user.email, password: failed_user.password })
      end.not_to change(User, :count)
      expect(graph_response['data']['addUser']['user']).to be_nil
      expect(graph_response['data']['addUser']['errors']).to include('Email has already been taken')
    end
  end

  context 'when email is blank' do
    let!(:user) { build(:user, email: '') }
    let(:query) do
      <<-GRAPHQL
      mutation addUser($email: String!, $password: String!) {
        addUser(input: { email: $email, password: $password }) {
          errors
          user {
            id
            email
          }
        }
      }
      GRAPHQL
    end

    it 'does not create a new user with blank email' do
      expect do
        post_graph(query, { email: user.email, password: user.password })
      end.not_to change(User, :count)
      expect(graph_response['data']['addUser']['user']).to be_nil
      expect(graph_response['data']['addUser']['errors']).to include("Email can't be blank")
    end
  end

  context 'when password is blank' do
    # user.password becomes nil when initialized with a blank password.
    let!(:user) { build(:user) }
    let(:query) do
      <<-GRAPHQL
      mutation addUser($email: String!, $password: String!) {
        addUser(input: { email: $email, password: $password }) {
          errors
          user {
            id
            email
          }
        }
      }
      GRAPHQL
    end

    it 'does not create a new user with blank password' do
      # Pass "" directly to GraphQL to test password presence validation.
      expect do
        post_graph(query, { email: user.email, password: '' })
      end.not_to change(User, :count)
      expect(graph_response['data']['addUser']['user']).to be_nil
      expect(graph_response['data']['addUser']['errors']).to include("Password can't be blank")
    end
  end
end
