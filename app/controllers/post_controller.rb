class PostController < ApplicationController
  def tweet
    @twitter ||= MyTwitter.new
    @twitter.tag = "鳥貴族"
    @twitter.limit = "50"
    @twitter.tweet = @twitter.client.search("##{@twitter.tag}", lang: "ja", result_type: 'recent', count: 20).map do |tweet|
      Post.create_from_twitter tweet
    end
    render action: 'index'
  end
end
