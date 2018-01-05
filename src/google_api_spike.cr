require "./google_api_spike/*"

# TODO: Write documentation for `GoogleApiSpike`
module GoogleApiSpike

  HOME_VAR = "HOME"
  CREDENTIALS_FILE_NAME = "application_default_credentials.json"
  WELL_KNOWN_PATH = File.join(".config", "gcloud", CREDENTIALS_FILE_NAME)

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
  end
end

GoogleApiSpike.main
