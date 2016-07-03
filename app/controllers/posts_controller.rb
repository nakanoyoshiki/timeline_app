class PostsController < ApplicationController
  def index
    @post = Post.order('post_time desc').limit(100)
  end

  def update
    create_from_gnavi


    @twitter ||= MyTwitter.new
    @twitter.client.search('鳥貴族', lang: "ja", result_type: 'recent', count: 2).map do |tweet|
      create_from_twitter tweet
    end
    #
    # respond_to do |format|
    #   if @updatetweet.save
    #     format.html { render action: "index", notice: 'Timeline was successfully updated.' }
    #   end
    # end

  #   rescue => e
  #      logger.error e.message
  #      flash[:error] = "エラーが起きました[#{e.message}]"
  #      redirect_to root_path
  end

  def create_from_twitter tweet
    str = tweet.user.created_at.to_s
    time = Time.parse(str)
    @key_check = Post.where(key: tweet.id, api_type: "twitter" )
    if @key_check.blank?
      Post.create(text: tweet.text,  api_type: 'twitter', key: tweet.id,image: tweet.user.profile_image_url  ,post_time: time)
    end
  end

  def create_from_gnavi
    key = 'e9c5ed396a549bfdf2bb6fe8c3cc0d3d'
    @restaurant_url ||= "http://api.gnavi.co.jp/PhotoSearchAPI/20150630/?keyid=#{key}&format=json&comment=美味しい&sort=1&hit_per_page=10"
    @restaurant = JSON.parse(Net::HTTP.get(URI.parse(URI.escape(@restaurant_url))))
    @gnavi = @restaurant['response']
    @gnavi.delete('@attributes')
    @gnavi.delete('total_hit_count')
    @gnavi.delete('hit_per_page')
    @key_check = Post.where(key: @gnavi['0']['photo']['vote_id'], api_type: 'gnavi' )
    if @key_check.blank?
      @ans =  Post.create(text: @gnavi['0']['photo']['comment'], api_type: 'gnavi' , key: @gnavi['0']['photo']['vote_id'], image: @gnavi['0']['photo']['image_url']['url_320'], post_time: @gnavi['0']['photo']['update_date'])
    end
    @key_check = Post.where(key: @gnavi['1']['photo']['vote_id'], api_type: 'gnavi' )
    if @key_check.blank?
      @ans =  Post.create(text: @gnavi['1']['photo']['comment'], api_type: 'gnavi' , key: @gnavi['1']['photo']['vote_id'], image: @gnavi['1']['photo']['image_url']['url_320'], post_time: @gnavi['1']['photo']['update_date'])
    end
    @key_check = Post.where(key: @gnavi['2']['photo']['vote_id'], api_type: 'gnavi' )
    if @key_check.blank?
      @ans =  Post.create(text: @gnavi['2']['photo']['comment'], api_type: 'gnavi' , key: @gnavi['2']['photo']['vote_id'], image: @gnavi['2']['photo']['image_url']['url_320'], post_time: @gnavi['2']['photo']['update_date'])
    end
    @key_check = Post.where(key: @gnavi['3']['photo']['vote_id'], api_type: 'gnavi' )
    if @key_check.blank?
      @ans =  Post.create(text: @gnavi['3']['photo']['comment'], api_type: 'gnavi' , key: @gnavi['3']['photo']['vote_id'], image: @gnavi['3']['photo']['image_url']['url_320'], post_time: @gnavi['3']['photo']['update_date'])
    end
    @key_check = Post.where(key: @gnavi['4']['photo']['vote_id'], api_type: 'gnavi' )
    if @key_check.blank?
      @ans =  Post.create(text: @gnavi['4']['photo']['comment'], api_type: 'gnavi' , key: @gnavi['4']['photo']['vote_id'], image: @gnavi['4']['photo']['image_url']['url_320'], post_time: @gnavi['4']['photo']['update_date'])
    end
    @key_check = Post.where(key: @gnavi['5']['photo']['vote_id'], api_type: 'gnavi' )
    if @key_check.blank?
      @ans =  Post.create(text: @gnavi['5']['photo']['comment'], api_type: 'gnavi' , key: @gnavi['5']['photo']['vote_id'], image: @gnavi['5']['photo']['image_url']['url_320'], post_time: @gnavi['5']['photo']['update_date'])
    end
    @key_check = Post.where(key: @gnavi['6']['photo']['vote_id'], api_type: 'gnavi' )
    if @key_check.blank?
      @ans =  Post.create(text: @gnavi['6']['photo']['comment'], api_type: 'gnavi' , key: @gnavi['6']['photo']['vote_id'], image: @gnavi['6']['photo']['image_url']['url_320'], post_time: @gnavi['6']['photo']['update_date'])
    end

    redirect_to root_path
  end
end