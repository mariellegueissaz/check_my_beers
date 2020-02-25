class BeersController < ApplicationController
  def index
    if params[:name].present?
      sql_query = " \
      name ILIKE :query \
      "
      @beers = Beer.where(sql_query, query: "%#{params[:name]}%")
    elsif params[:brewery].present? || params[:category].present? || params[:beer_type].present? || params[:location].present?
      @beers = Beer.all
      @beers = @beers.where("brewery LIKE '%#{params[:brewery]}%'") if params[:brewery].present?
      @beers = @beers.where("category LIKE '%#{params[:category]}%'") if params[:category].present?
      @beers = @beers.where("beer_type LIKE '%#{params[:beer_type]}%'") if params[:beer_type].present?
      @beers = @beers.where("location LIKE '%#{params[:location]}%'") if params[:location].present?
    else
      @beers = Beer.all
    end
 end

  def show
    @beer = Beer.find(params[:id])
     if @beer.photo.attached?
      @photo = @beer.photo
    else
      @photo = "https://static.mycity.travel/manage/uploads/7/40/117655/1/biere_3000.jpg"
    end
  end

  def scan

  end
end
