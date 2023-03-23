class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]

    if params[:search].blank? || params[:word].blank?
      flash.now[:alert] = "検索キーワードを入力してください。"
      render :search and return
    end

  if @range == "User"
  @users = User.looks(params[:search], params[:word])
  else
  @books = Book.looks(params[:search], params[:word])
  @books = [] if @books.nil?
  end

  end
end
