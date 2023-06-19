module Users
  class RegistrationsController < DeviseTokenAuth::ApplicationController
    # before_action :authenticate_user!, except: :create
    protect_from_forgery with: :null_session
    before_action :set_referral

    def create
      user = User.new(sign_up_params)
      user.referrer = @referrer
      if user.save
        render json: { email: user.email,
                       message: 'Sign Up Successful' }, status: :ok
      else
        render json: { errors: user.errors.full_messages, status: :unprocessable_entity }
      end
    end

    private

    def sign_up_params
      params.permit(:email, :password, :password_confirmation)
    end

    def set_referral
      return unless params[:user_invitation_token].present?

      @referrer = User.find_by(referral_token: params[:user_invitation_token])
    end
  end
end