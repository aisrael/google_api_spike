require "json"

class UserRefreshCredentials
  JSON.mapping(
    client_id: String,
    client_secret: String,
    refresh_token: String,
    type: String
  )
end
