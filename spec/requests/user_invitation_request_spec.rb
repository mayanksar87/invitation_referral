# frozen_string_literal: true
require 'rails_helper'

RSpec.describe UserInvitationsController, type: :request do

  before(:each) do
    @user =  FactoryBot.create(:user)
    referred_from = UserInvitation.create(referred_from: @user.id, email: 'test@gmail.com')
  end

  describe 'sign up' do
    it 'returns a successful response' do
      post '/auth',params: {
        "email": 'john@gmail.com',
        "password": "password",
        "password_confirmation": "password"
      }
      
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'sign in' do
    it 'returns a successful response' do
      post '/auth/sign_in',params: {
        "email": 'john@gmail.com',
        "password": "password"
      } 
      @response_uid = response.header["uid"]
      @response_access_token = response.header["access-token"]
      @response_client = response.header["client"]
      @response_authorization = response.header["Authorization"]
      expect(response).to have_http_status(:ok)
    end
  end
  
  describe 'index request' do 
    it 'get request' do
      get '/user_invitations', params: {}, headers: {'access-token' => @response_access_token, 'uid' => @response_uid, 'client' => @response_client, 'Authorization' => @response_authorization}
      expect(response).to have_http_status(:ok)
    end
  end
end