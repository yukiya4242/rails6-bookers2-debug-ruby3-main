class MessagesController < ApplicationController



  def index
    @message = Message.new
    @messages = Message.all

  def new
    @message = Message.new
  end


def create
  @recipient = User.find(params[:id])
  if current_user.following?(@recipient) # フォローしているユーザーにだけDMを送信
    @message = current_user.sent_messages.build(message_params)
    if @message.save
      redirect_to messages_path, notice: 'Message was successfully sent.'
    else
      render :new
    end
  else
    redirect_to messages_path, alert: 'You can only send a message to users you are following.'
  end
end

  def show

  end

  def destroy
    @message.destroy
    redirect_to message_path, notice: 'Message was successfully deleted.'
  end





  def message_params
    params.require(:message).permit(:content, :recipient_id)
  end

  def set_message
    @message = Message.find(params[:id])
  end

end
end