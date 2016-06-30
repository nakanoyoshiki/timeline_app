class MyTwitter
  include ActiveModel::Model
  attr_accessor :tweet

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = "DVflD2nAIY5SXfr9mtWKXWr8c"
      config.consumer_secret = "McLiKtby5Ng0LsZ8hSW1Ix3SrQ2KqleQ4OLa4fgPaEfUZq13U0"
      config.access_token = '495527233-BLgpO98SCn7DOgSF6xZwWB7fhRZUxjhfG8uOX3MK'
      config.access_token_secret = 'OQgahTY1c0tvgvyGBfy8IY3CWFu3Dfp14NtnyspWRqsCX'
    end
  end
end
