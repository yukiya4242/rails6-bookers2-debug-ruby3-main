class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]

    if params[:search].blank? || params[:word].blank?
      flash.now[:alert] = "検索キーワードを入力してください。"

    end

if @range == "User"
    @users = User.looks(params[:search], params[:word])
else
    @books = Book.looks(params[:search], params[:word])
    if @books.nil?
      flash.now[:alert] = "検索結果が見つかりませんでした。"
      @books = []
    end
end
    end
end