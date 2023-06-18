class UserInvitation < ApplicationRecord
  enum status: {
          pending: 'pending',
					sent: 'sent',
          accepted: 'accepted'
        }, _default: 'pending'
        
  validates :email, presence: true, uniqueness: true
	belongs_to :referrer, class_name: 'User', foreign_key: :referred_from
	after_create :user_invite, :update_user_invitation_status

  private

  def user_invite
    UserInvitationMailer.mailer(id).deliver_now
  end

  def update_user_invitation_status
    update(status: sent)
	end
end
