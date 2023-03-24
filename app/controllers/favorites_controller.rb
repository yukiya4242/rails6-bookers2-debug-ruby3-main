# app/controllers/favorites_controller.rb

class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    current_user.favorite(@book)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @book = Favorite.find(params[:id]).book
    current_user.unfavorite(@book)
    respond_to do |format|
      format.js
    end
  end
end




# class FavoritesController < ApplicationController

#   def create
#     book = Book.find(params[:book_id])
#     favorite = current_user.favorites.new(book_id: book.id)
#     favorite.save
#     #redirect_to books_path
#   end
# end


#   def destroy
#     book = Book.find(params[:book_id])
#     favorite = current_user.favorites.find_by(book_id: book.id)
#     favorite.destroy
#     #redirect_to book_path(book)
#   end

