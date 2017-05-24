class MessageSender
  def self.send_code(phone, code)
    account_sid = ENV['twillio_account_sid']
    auth_token  = ENV['twillio_auth_token']
    client = Twilio::REST::Client.new(account_sid, auth_token)

    message = client.messages.create(
      from:  ENV['twillio_number'],
      to:    phone,
      body:  code
    )

    message.status == 'queued'
  end
end
