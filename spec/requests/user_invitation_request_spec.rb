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
end