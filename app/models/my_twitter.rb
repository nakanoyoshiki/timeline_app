class MyTwitter
  TWITTER_CONFIG = YAML.load_file(Rails.root.join("config/twitter.yml"))[Rails.env]
  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = MyTwitter::TWITTER_CONFIG['consumer_key']
      config.consumer_secret = MyTwitter::TWITTER_CONFIG['consumer_secret']
      config.access_token = MyTwitter::TWITTER_CONFIG['access_token']
      config.access_token_secret = MyTwitter::TWITTER_CONFIG['access_token_secret']
    end
  end
end