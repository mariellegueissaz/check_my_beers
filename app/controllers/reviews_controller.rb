class ReviewsController < ApplicationController

 def new
    @beer = Beer.find(params[:beer_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @beer = Beer.find(params[:beer_id])
    @review.beer = @beer
    @review.user = current_user
    @review.save
    redirect_to beer_path(@beer)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def review_params
    params.require(:review).permit(:content, :rate, :title, :created_at)
  end
end
