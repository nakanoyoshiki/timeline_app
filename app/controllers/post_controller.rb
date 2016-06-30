class PostController < ApplicationController
  def index
  end

  def new
    @twitter ||= MyTwitter.new
    tag = "鳥貴族"
    @twitter.tweet = @twitter.client.search("##{tag}", lang: "ja", result_type: 'recent', count: 20).map do |tweet|
      create_from_twitter tweet

       # {
       #     icon: tweet.user.profile_image_url,
       #     text: tweet.id,
       #     data: tweet.user.created_at
       # }
    end
    @post = Post.all
    render action: 'index'
  end

  def create_from_twitter tweet
    Post.create(text: tweet.text, image: tweet.user.profile_image_url)
  end
end
