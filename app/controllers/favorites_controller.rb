class FavoritesController < ApplicationController
  def index
    id = Favorite.select(:post_id)
    @post = Post.where(id: id)
  end
  def create
    if cookies[:user_id].blank?
      cookies[:user_id] =  {
          :value => SecureRandom.hex(10),
          :expires => 1.months.from_now
      }
    end

    post = Post.find(params[:post_id])

    unless Favorite.find_by user_id: cookies[:user_id], post_id: params[:post_id]
      Favorite.create(user_id: cookies[:user_id], post_id: params[:post_id])
    end
    render partial: "favorite_btn", locals: { post: post }
  end

  def destroy
    favorite = Favorite.where(id: params[:id]).first
    post = Post.find(params[:post_id])
    if favorite
      favorite.destroy
    end
    render partial: "favorite_btn", locals: { post: post }
  end
end
