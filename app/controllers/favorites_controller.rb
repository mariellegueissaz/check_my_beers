class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.all.where(user: current_user)
    @beers_recommended = Beer.all.sample(3)
  end

  def create
    @favorite = Favorite.new
    if params[:beer_id].nil?
      @beer = Beer.find(params[:favorite][:beer_id])
    else
      @beer = Beer.find(params[:beer_id])
    end
    @favorite.beer = @beer
    @favorite.user = current_user
    @favorite.name = @beer.name
    if current_user.favorites.where(beer: @beer).empty?
      if @favorite.save
        redirect_to myfavorites_path
      end
    else
        redirect_to beer_path(@beer), error: "Beer already saved!"
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    beer = @favorite.beer
    @favorite.user = current_user
    @favorite.destroy
    redirect_to myfavorites_path
  end

  private

  def favorite_params
    params.require(:favorite).permit(:user_id, :beer_id)
end

end
