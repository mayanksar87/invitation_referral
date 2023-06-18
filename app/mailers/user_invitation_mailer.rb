
class UserInvitationMailer < ApplicationMailer
  def mailer(id)
    @invitation = UserInvitation.find(id)
    @referred_from = @invitation.referrer
    mail(to: @invitation.email,
        subject: "#{@referred_from.email} sent you a invitation"
    )
  end
end