module OmniauthMacros
  def mock_auth_hash
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:facebook] = {
      'provider' => 'facebook',
      'uid' => '123545',
      'info' => {
        'name' => 'mockuser',
        'email' => 'mock@gmail.com'
      },
      'credentials' => {
        'token' => '140925763026116',
        'secret' => ENV['APP_SECRET']
      }
    }
  end
end
