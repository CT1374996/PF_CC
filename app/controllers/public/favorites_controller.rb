class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  def create
    @impression = Impression.find(params[:impression_id])
    favorite = current_user.favorites.new(impression_id: @impression.id)
    # favorite = Favorite.new(favorite_params)
    # favorite.user_id = current_user.id
    favorite.save
    redirect_to impression_path(@impression.id)
  end

  def destroy
    impression = Impression.find(params[:impression_id])
    favorite = current_user.favorites.find_by(impression_id: impression.id)
    favorite.destroy
    redirect_to impression_path(impression)
  end
end
