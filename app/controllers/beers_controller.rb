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
    @marker = [ { lat: @beer.latitude, lng: @beer.longitude, infoWindow: render_to_string(partial: "info_window", locals: { beer: @beer }), image_url: helpers.asset_url('beer_pin.png') } ]
    if @beer.photo.attached?
      @photo = @beer.photo
    else
      @photo = "default-picture.jpg"
    end
    beer_rate
  end

  def scan

  end

  def find_beer_from_scan
    @barcode = params[:code]
    @beer = Beer.find_by(barcode: @barcode)
    render json: @beer.as_json(only: [:id])
  end

  def beer_rate
    @beer = Beer.find(params[:id])
    sum = 0
    @reviews = @beer.reviews
    @reviews.each do |review|
    sum = sum + review.rate
    end
    if @reviews.count == 0
      @beer_rate = 1
    else
    @beer_rate = sum / @reviews.count
  end
  end

end
