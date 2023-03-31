class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, only: [:edit, :update, :destroy]


  def index
    @book = Book.new
    @groups = Group.all
  end

  def join
    @group = Group.find(params[:group_id])
    @group.users << current_user
    redirect_to groups_path
  end

  def new_mail
    @group = Group.find(params[:group_id])
  end



  def send_mail
    @group = Group.find(params[:group_id])
    group_users = @group_users
    @mail_title = params[:mail_title]
    @mail_content = params[:mail_content]
    ContactMailer.send_mail(@mail_title, @mail_content,group_users).deliver
  end


  def show
    @book = Book.new
    @group = Group.find(params[:id])
    # @user = @group.users
  end



  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
      render 'edit'
    end
  end



  def new
    @group = Group.new
  end



  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    if @group.save
      redirect_to groups_path
    else
      render 'new'
    end
  end



  def edit
     @user = current_user
    if @user != current_user
      redirect_to books_path(current_user)
    end
  end

  def destroy
    @group = Group.find(params[:id])
    #current_userは、@group.usersから消されるという記述。
    @group.users.delete(current_user)
    redirect_to groups_path
  end



private

  def group_params
    params.require(:group).permit(:name, :introduction, :imgae)
  end


  def ensure_current_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end