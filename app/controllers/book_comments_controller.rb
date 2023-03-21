class BookCommentsController < ApplicationController

  def cerate
    book = Book.find(params[:book_id])
    comment = current_user.bookcomments.new(bookcomment_params)
    comment.book_id = book.id
    comment.save
    redirect_to book_path(book)
  end



  def destroy
    comment = current_user.book_comments.find(params[:id])
    book = comment.book
    comment.destroy
    redirect_to book_path(book)
  end


  private

  def bookcomment_params
   params.require(:book_comment).permit(:comment)
  end


end

