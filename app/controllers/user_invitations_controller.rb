class UserInvitationsController < ApplicationController
	protect_from_forgery with: :null_session
	before_action :authenticate_user!

	def index
		user_invitations = current_user.user_invitations
		render json: UserInvitationSerializer.new(user_invitations), status: :ok
	end

	def create
		user_invitation = UserInvitation.new(user_invitation_params)
		user_invitation.referred_from = current_user.id
		if user_invitation.save
			render json: UserInvitationSerializer.new(user_invitation), status: :ok
		else
			render json: { errors: user_invitation.errors }, status: :unprocessable_entity
		end
	end
	

	private

	def user_invitation_params
		params.require(:user_invitation).permit(:email)
	end
end
