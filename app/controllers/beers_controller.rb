class BeersController < ApplicationController
  def index
    @beers = Beer.all
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

  def find_beer_from_scan
    @barcode = params[:code]

      @beer = Beer.find_by(barcode: @barcode)
      render json: @beer.as_json(only: [:id])



  end

end
