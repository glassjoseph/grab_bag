RSpec.configure do
  def stub_oauth
    OmniAuth.config.test_mode = true

    auth_hash = {
      "provider"=>"facebook",
      "uid"=>"10103559484486366",
      "info"=> {
        "email"=>ENV['facebook_email'],
        "name"=>ENV['facebook_name'],
        "image"=>"http://graph.facebook.com/v2.6/10103559484486366/picture"
      },
      "credentials"=> {
        "token"=> ENV['facebook_token'],
        "expires_at"=>1500238611,
        "expires"=>true
      },
      "extra"=> {
        "raw_info"=> {
          "name"=>ENV['facebook_name'],
          "email"=>ENV['facebook_email'],
          "id"=>"10103559484486366"
        }
      }
    }

    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(auth_hash)
  end
end
