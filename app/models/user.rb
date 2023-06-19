# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  belongs_to :referrer, class_name: 'User', foreign_key: 'referrer_id', optional: true
  has_many :user_invitations, class_name: 'UserInvitation', foreign_key: 'referred_from'
  
  before_create :user_referral_token
  after_create :update_user_referral_status

  private

  def user_referral_token
    self.referral_token = SecureRandom.hex(5)
  end

  def update_user_referral_status
    UserInvitation.find_by_email(email).update(status: :accepted) if referrer_id
  end
end
