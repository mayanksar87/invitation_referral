# app/serializers/user_invitation_serializer.rb
class UserInvitationSerializer
  include JSONAPI::Serializer
  attributes :id,  :email,:status, :created_at, :updated_at
end