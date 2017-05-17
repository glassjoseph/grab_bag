
RSpec.configure do
  def stub_oauth
    OmniAuth.config.test_mode = true

    auth_hash = {
      user_info: {name: "Sam Landfried", email: 'samlandfried@gmail.com'},
      uid: "1234",
      provider: "facebook",
      credentials: {token: "whatever"}
    }

    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(auth_hash)
  end
end
