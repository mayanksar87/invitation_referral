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
end
