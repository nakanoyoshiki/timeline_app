class PostController < ApplicationController
  require 'json'
  require 'uri'
  def index
  end

  def new
    @twitter ||= MyTwitter.new
    @twitter.tweet = @twitter.client.search('鳥貴族', lang: "ja", result_type: 'recent', count: 20).map do |tweet|
      create_from_twitter tweet
    end


    key = 'e9c5ed396a549bfdf2bb6fe8c3cc0d3d'
    @restaurant_url ||= "http://api.gnavi.co.jp/PhotoSearchAPI/20150630/?keyid=#{key}&format=json&shop_name=鳥貴族&hit_per_page=30"
    @restaurant ||= JSON.parse(Net::HTTP.get(URI.parse(URI.escape(@restaurant_url))))
    @post = Post.all
    render action: 'index'
  end

  def create_from_twitter tweet
    str = tweet.user.created_at
    format =  ['%Y:%m:%d %H:%M:%S']
    d = DateTime.strptime(str, format)
    Post.create(text: tweet.text, image: tweet.user.profile_image_url ,post_time: d, type: 'twitter' , key: tweet.id)
  end
end