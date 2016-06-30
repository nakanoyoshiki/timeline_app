class PostController < ApplicationController
  def index
  end

  def new
    @twitter ||= MyTwitter.new
    @twitter.tweet = @twitter.client.search('鳥貴族', lang: "ja", result_type: 'recent', count: 20).map do |tweet|
       create_from_twitter tweet
    end
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
