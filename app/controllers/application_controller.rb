class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :user_favorite
  helper_method :user_favorites


  def user_favorite post
    Favorite.where(user_id: cookies[:user_id]).where(post: post.id).first
  end

  def user_favorites
    Favorite.where(user_id: cookies[:user_id] || 0).all
  end
end
