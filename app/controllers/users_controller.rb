class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]
  before_action :authenticate_user!, except: [:top]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @book = Book.find(params[:book_id]) if params[:book_id]
    @users = User.all
  end

  def index
    @users = User.all
    @user = User.new
    @book = Book.new
  end

  def edit
    @user = current_user
    if @user != current_user
      #redirect_to edit_user_path
      redirect_to user_path(current_user)
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
