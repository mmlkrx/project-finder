class MessagesController < ApplicationController

  def create
    @message = Message.create!(message_params)
    render 'messages/create', message: @message
  end

  private
  def message_params
    params.require(:message).permit(:text, :user_id, :project_id)
  end

end