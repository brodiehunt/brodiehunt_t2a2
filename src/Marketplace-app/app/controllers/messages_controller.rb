class MessagesController < ApplicationController
  before_action :find_conversation
  before_action :authenticate_user!
  # Database is queried for all the messages related to the conversation_id
  # A new  message instance is stored under @message variable for use in view
  # The if statement checks to see if the current user is identified as the sender in this conversation
  # If they are, the profile database table is queried to a profile which has the same user_id that 
  # belongs to the people involved in this conversation. 
  # it is structured this way as to always have the current user saved under the @sender variable
  # so that it can be used to display the correct name above each message in the view
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
  # Creates a new instance of a message using the parameters passed from the form on the page.
  # If the message is saved to the database, the user is redirected to the conversation. (same page in this case)
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

    # Queries the database to find a specific conversation. 
    def find_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end

end