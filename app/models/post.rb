class Post < ActiveRecord::Base
  def create_from_twitter tweet
    Post.create(text: tweet.text, image: tweet.user.profile_image_url)
  end
end
