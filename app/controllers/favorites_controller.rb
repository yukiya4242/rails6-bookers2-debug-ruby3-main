class FavoritesController < ApplicationController



#   def create
#   @book = Book.find(params[:book_id])
#   current_user.like(@book)
#   respond_to do |format|
#     format.html { redirect_to request.referrer || root_url }
#     format.js
#   end
# end

# def destroy
#   @book = Favorite.find(params[:id]).book
#   current_user.unlike(@book)
#   respond_to do |format|
#     format.html { redirect_to request.referrer || root_url }
#     format.js
#   end
# end

  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    redirect_to books_path
  end


  def destroy
    book = Book.find(params[:book_id])
    favorites = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    redirect_to book_path(book)
  end
end
