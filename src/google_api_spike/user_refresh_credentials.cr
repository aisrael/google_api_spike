require "json"

class UserRefreshCredentials

  # The default token credential URI
  TOKEN_CREDENTIAL_URI = "https://www.googleapis.com/oauth2/v4/token"

  JSON.mapping(
    client_id: String,
    client_secret: String,
    refresh_token: String,
    type: String
  )
end
