class MessagesController < ApplicationController



  def index
    @message = Message.new
    @messages = Message.all
    @recipient = current_user.received_messages.map(&:sender).uniq


  end

  def new
    @message = Message.new
  end


def create
  @recipient = User.find_by(id: params[:message][:recipient_id])

  if current_user.following?(@recipient) # フォローしているユーザーにだけDMを送信
    @message = current_user.sent_messages.build(message_params)
    if @message.save
      redirect_to messages_path, notice: 'Message was successfully sent.'
    else
      render :new
    end
  else
    flash[:alert] = "You can't send messages to users you're not following."
    redirect_to messages_path(@recipient)
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
