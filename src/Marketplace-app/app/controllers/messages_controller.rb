class MessagesController < ApplicationController
  before_action :find_conversation
  before_action :authenticate_user!

  def index
    @messages = @conversation.messages
    @message = @conversation.messages.new
    if @conversation.sender_id == current_user.id
      @sender = Profile.find_by(user_id: @conversation.sender_id)
      @recipient = Profile.find_by(user_id: @conversation.recipient_id)
    else
      @sender = Profile.find_by(user_id: @conversation.recipient_id)
      @recipient = Profile.find_by(user_id: @conversation.sender_id)
    end
  end

  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  def new 
    @messages = @conversation.messages.new
  end


  private
    def message_params
      params.require(:message).permit(:body, :user_id)
    end

    def find_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end

end