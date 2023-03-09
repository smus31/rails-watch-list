class BookmarksController < ApplicationController
  before_action :set_list, only: %i[new create]
  # before_action :set_movie, only: %i[new create]

  def new
    # We need @restaurant in our `simple_form_for`
    @bookmark = Bookmark.new
  end

  def create
    # @review = Review.new(review_params)
    # @review.restaurant = @restaurant
    # @review.save
    # redirect_to restaurant_path(@restaurant)
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list

    @bookmark.movie_id = params[:bookmark][:movie_id]
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render "lists/show", status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment)
  end
end
