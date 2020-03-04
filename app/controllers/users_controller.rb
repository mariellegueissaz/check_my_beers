class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @marker = [ { lat: @user.latitude, lng: @user.longitude, infoWindow: render_to_string(partial: "info_window", locals: { beer: @beer }), image_url: helpers.asset_url('beer_pin.png') } ]
  end
end
