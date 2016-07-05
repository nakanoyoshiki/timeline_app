class PostsController < ApplicationController
  def index
    create_from_gnavi
    @posts = Post.order('post_time desc').limit(100)
  end

  def update
    create_from_gnavi

    @twitter ||= MyTwitter.new
    @twitter.client.search('鳥貴族', lang: "ja", result_type: 'recent',count: 20).each do |tweet|
      create_from_twitter tweet
    end

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Timeline was successfully updated.' }
    end
    rescue => e
    logger.error e.message
    flash[:error] = "エラーが起きました[#{e.message}]"
    redirect_to root_path
  end

  def create_from_twitter tweet
    str = tweet.user.created_at.to_s
    time = Time.parse(str)
    @key_check = Post.where(key: tweet.id, api_type: "twitter" )
    if @key_check.blank?
      Post.create(text: tweet.text,  api_type: 'twitter', key: tweet.id,image: tweet.user.profile_image_url_https  ,post_time: time)
    end
  end

  def create_from_gnavi
    key = 'e9c5ed396a549bfdf2bb6fe8c3cc0d3d'
    @search_url ||= "http://api.gnavi.co.jp/PhotoSearchAPI/20150630/?keyid=#{key}&format=json&comment=美味しい&sort=1&hit_per_page=10"
    @response = JSON.parse(Net::HTTP.get(URI.parse(URI.escape(@search_url))))
    @gnavi = @response['response']
    @nums = ['\'0\'','\'1\'','\'2\'','\'3\'','\'4\'','\'5\'','\'6\'','\'7\'','\'8\'','\'9\'']
    (0..9).each do |i|
      @num = @nums[i]
      @key_check = Post.where(key: @gnavi[@num[1]]['photo']['vote_id'], api_type: "gnavi" )
      if @key_check.blank?
        Post.create(text: @gnavi[@num[1]]['photo']['comment'],
                    api_type: 'gnavi' ,
                    key: @gnavi[@num[1]]['photo']['vote_id'],
                    image: @gnavi[@num[1]]['photo']['image_url']['url_320'],
                    post_time: @gnavi[@num[1]]['photo']['update_date'])
      end
    end
  end
end