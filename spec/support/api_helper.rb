# frozen_string_literal: true

module ApiHelpers
 def authentication_token(account)
  JsonWebToken.encode(user_id: account.id)
 end
end
  