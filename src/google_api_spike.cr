require "http"

require "./google_api_spike/*"

# TODO: Write documentation for `GoogleApiSpike`
module GoogleApiSpike
  HOME_VAR              = "HOME"
  CREDENTIALS_FILE_NAME = "application_default_credentials.json"
  WELL_KNOWN_PATH       = File.join(".config", "gcloud", CREDENTIALS_FILE_NAME)

  def self.generate_access_token_request(credentials, options = {} of Symbol => String) : Hash(String, String)
    parameters = {"grant_type" => "refresh_token"}
    parameters["refresh_token"] = credentials.refresh_token
    parameters["client_id"] = credentials.client_id
    parameters["client_secret"] = credentials.client_secret
    if options.has_key?(:scope)
      parameters["scope"] = options[:scope]
    end
    parameters
  end

  def self.read_json_creds(path)
    UserRefreshCredentials.from_json(File.read(path))
  end

  def self.main
    home_var = "HOME"
    home = ENV.has_key?(HOME_VAR) && !ENV[HOME_VAR].nil? ? ENV[HOME_VAR] : ""
    credentials_file_path = File.join(home, WELL_KNOWN_PATH)
    unless File.file?(credentials_file_path)
      puts "\"#{credentials_file_path}\" does not exist!"
      exit 1
    end
    puts "Reading #{credentials_file_path}..."

    credentials = read_json_creds(credentials_file_path)
    p credentials

    request = generate_access_token_request(credentials)
    p request

    url = UserRefreshCredentials::TOKEN_CREDENTIAL_URI
    resp = HTTP::Client.post(url, form: request)

    puts resp.status_code
    unless resp.status_code == 200
      puts resp.status_message
      exit 1
    end
    json_body = JSON.parse(resp.body)

    puts "Authorization: Bearer #{json_body["access_token"]}"
  end
end

GoogleApiSpike.main
