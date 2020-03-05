require 'csv'

class BeersController < ApplicationController
  def index
    if params[:lat].present?
      @lat = params[:lat]
      @lon = params[:lon]
      @div = false
      @div1 = true
      @beers = Beer.near([@lat, @lon], 100)
      @markers = @beers.map { |b| { lat: b.latitude, lng: b.longitude, infoWindow: render_to_string(partial: "info_window", locals: { beer: b }), image_url: helpers.asset_url('beer_pin.png') } }
    elsif params[:name].present?
      sleep(2)
      @div = true
      @div1 = false
      sql_query = " \
      name ILIKE :query \
      "
      @beers = Beer.where(sql_query, query: "%#{params[:name]}%")
      @markers = @beers.map { |b| { lat: b.latitude, lng: b.longitude, infoWindow: render_to_string(partial: "info_window", locals: { beer: b }), image_url: helpers.asset_url('beer_pin.png') } }
    elsif params[:brewery].present? || params[:category].present? || params[:beer_type].present? || params[:location].present?
      sleep(2)
      @div = true
      @beers = Beer.all
      @beers = @beers.where("brewery LIKE '%#{params[:brewery]}%'") if params[:brewery].present?
      @beers = @beers.where("category LIKE '%#{params[:category]}%'") if params[:category].present?
      @beers = @beers.where("beer_type LIKE '%#{params[:beer_type]}%'") if params[:beer_type].present?
      @beers = @beers.where("location LIKE '%#{params[:location]}%'") if params[:location].present?
      @markers = @beers.map { |b| { lat: b.latitude, lng: b.longitude, infoWindow: render_to_string(partial: "info_window", locals: { beer: b }), image_url: helpers.asset_url('beer_pin.png') } }
    else
      @div = false
      @div1 = false
      @beers = Beer.all
    end
  end


  def show
    @beer = Beer.find(params[:id])
    @marker = [ { lat: @beer.latitude, lng: @beer.longitude, infoWindow: render_to_string(partial: "info_window", locals: { beer: @beer }), image_url: helpers.asset_url('beer_pin.png') } ]
    if @beer.photo.attached?
      @photo = @beer.photo
    elsif @beer.picture_url.nil?
      @photo = "default-picture.jpg"
    else
      @photo = @beer.picture_url
    end
    beer_rate
  end

  def new
    @beer = Beer.new
    @barcode = params[:code]
  end

  def create
    @beer = Beer.new(beer_params)
    CSV.open('beers.csv', 'ab') do |csv|
      csv << [@beer.barcode, @beer.name, @beer.brewery, @beer.beer_type, @beer.location]
    end
    if @beer.save
      redirect_to beer_path(@beer)
    else
      render :new
    end
  end

  def scan

  end

  def guide

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
      @beer_rate = 0
    else
      @beer_rate = sum / @reviews.count
    end
  end

private

  def beer_params
    params.require(:beer).permit(:barcode, :name, :beer_type, :brewery, :location, :category, :degree, :photo)

  end
end
