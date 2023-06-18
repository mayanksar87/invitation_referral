# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserInvitation, type: :model do

  describe 'after_validation callback' do
    let(:user) { FactoryBot.create(:user) }
    let(:user_invitation) { FactoryBot.create(:user_invitation, referred_from: user.id) }
  end


  describe 'validations' do
    it 'requires presence of email' do
      user_invitation = UserInvitation.new
      expect(user_invitation).to_not be_valid
      expect(user_invitation.errors[:email]).to include("can't be blank")
    end

    it 'requires uniqueness of email' do
      user_invitation = UserInvitation.new(email: 'test@example.com')
      expect(user_invitation).to_not be_valid
      expect(user_invitation.errors[:email]).to eq([])
    end
  end
end