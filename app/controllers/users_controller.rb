class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]
  before_action :authenticate_user!, except: [:top]
  before_action :configure_permitted_parameters, if: :devise_controller?



  def search
    @user = User.find(params[:user_id])
    @books = @user.books
    @book = Book.new
    if params[:created_at] == ""
      @search_book = "日付を選択してください"
    else
      create_at = params[:created_at]
      @search_book = @books.where(['created_at LIKE ? ', "#{create_at}%"]).count
    end
  end


  def follow
    @user = User.find(params[:id])
    current_user.follow(@user)
    redirect_to @user
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @book = Book.find(params[:book_id]) if params[:book_id]
    @users = User.all
    @books_make_book_week = Book.make_book_week

    @today_book_count = @books.created_today.count
    @yesterday_book_count = @books.created_yesterday.count
    @this_week_book_count = @books.created_this_week.count
    @last_week_book_count = @books.created_last_week.count
    @yesterday_book = @books.created_yesterday.count
    if @yesterday_book_count.zero?
      @yesterday_book_percent = "-"
    else
      @yesterday_book_percent = (((@today_book_count.to_f / @yesterday_book_count.to_f) - 1) * 100).round(2)
    end

    if @last_week_book_count.zero?
      @last_week_percent = "-"
    else
      @last_week_percent = (((@this_week_book_count.to_f / @last_week_book_count.to_f) - 1) * 100).round(2)
    end
  end

  def index
    @users = User.all
    @user = User.new
    @book = Book.new
  end

  def edit
    @user = current_user
    if @user != current_user
      redirect_to books_path(current_user)
    end
  end

  def create
    @user = User.new(user_params)
    @user.user_id = current_user.id
    if @user.save
      log_in @user
      flash[:notice] = "Welcome! You have signed up successfully."
      redirect_to user_path(@user.id), notice: 'Profile updated successfully'
    else
      flash.now[:error] = "Error: failed to sign up."
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user.id)
    end
  end
end