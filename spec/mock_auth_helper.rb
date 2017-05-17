
RSpec.configure do
  def stub_oauth
    OmniAuth.config.test_mode = true

    auth_hash =
    {"provider"=>"facebook",
 "uid"=>"10103559484486366",
 "info"=>
  {"email"=>"jhg2v@virginia.edu",
   "name"=>"Joseph Glass",
   "image"=>"http://graph.facebook.com/v2.6/10103559484486366/picture"},
 "credentials"=>
  {"token"=>
    "EAAa4ZA9daWHABAEZC9llpZCsHsLfKQqyYWyrV1KrkKU0b7ZB1YkGkwaviQa6HJogiZBfzKgvZAm40MYvsFvMfC8hLDrQ98fTiZC9EqFj8puGtEYml
7UazrxatXKcRQSNhaIZAEvxua7tulyb1AxK4IjLdXpv4oAFhR8ZD",
   "expires_at"=>1500238611,

   "expires"=>true},
 "extra"=>{"raw_info"=>{"name"=>"Joseph Glass", "email"=>"jhg2v@virginia.edu", "id"=>"10103559484486366"}}}

    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(auth_hash)
  end
end
