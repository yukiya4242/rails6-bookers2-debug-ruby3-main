class BookCommentsController < ApplicationController
  before_action :set_book, only: [:create, :destroy]

   def create
    @book = Book.find(params[:book_id])
    @comment = @book.book_comments.new(bookcomment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "コメントを投稿しました。"
    else
      flash[:danger] = "コメントの投稿に失敗しました。"
    end
    redirect_to book_path(@book)
   end

   def show
  @book = Book.find(params[:id])
  @book_comment = BookComment.new
   end



def destroy
    @comment = BookComment.find(params[:id])
    if @comment.user_id == current_user.id
      @comment.destroy
      flash[:success] = "コメントを削除しました。"
    else
      flash[:danger] = "コメントの削除に失敗しました。"
    end
    redirect_to book_path(params[:book_id])
end


  # def destroy
  #   comment = current_user.book_comments.find(params[:id])
  #   book = comment.book
  #   comment.destroy
  #   redirect_to book_path(book)
  # end


  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def bookcomment_params
   params.require(:book_comment).permit(:comment, :text)
  end

end

