class ConversationsController < ApplicationController
  before_action :authenticate_user!
  # Queries the database to retrieve all profiles, used in the view to display user names
  # Queries the database for all conversation in which the current user is either a recipient 
  # or a sender. These conversations are displayed in the view. 
  def index
    @profiles = Profile.all
    @conversations = Conversation.where(sender_id: current_user.id).or(Conversation.where(recipient_id: current_user.id))
  end
  # intially Queries the database to see if a conversation exists between user (recipient and sender or vise versa)
  # if a conversation exists, instance variable @conversation assigned to the already created conversation
  # if conversation doesnt exist, creates a conversation between the two users
  def create
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private
    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end

end