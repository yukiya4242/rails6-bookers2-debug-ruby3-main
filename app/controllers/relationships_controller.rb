class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find(params[:followed_id])
    if user
    current_user.follow(user)
    flash[:notice] = 'フォローに成功しました'
    redirect_to user
    else
    redirect_to user_path, alert: 'User not found'
    end
  end

def destroy
  user = User.find_by(id: params[:followed_id])
  if user
    current_user.unfollow(user)
    flash[:notice] = 'フォローの解除に成功しました'
    redirect_to user
  else
    # userが見つからなかった場合のエラー処理
    redirect_to users_path, alert: 'User not found'
  end
end


  # def destroy
  #   user = Relationship.find(params[:id]).followed
  #   current_user.unfollow(user)
  #   redirect_to user
  # end
end
