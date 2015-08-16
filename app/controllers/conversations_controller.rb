class ConversationsController < ApplicationController
  before_filter :authenticate_user!

  layout false

  def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      @conversation = Conversation.new
      @conversation.sender_id = params[:sender_id]
      @conversation.save
      @conversation.users << User.find(params[:recipient_id])
    end


    render json: { conversation_id: @conversation.id }
  end

  def show
    @conversation = Conversation.find(params[:id])
    if(interlocutor(@conversation).is_a?(ActiveRecord::Associations::CollectionProxy))
      @reciever = ''
      interlocutor(@conversation).each do |user|
        @reciever << user.name << ' '  
      end
      @reciever.chop
    else  
      @reciever = interlocutor(@conversation).name
    end
    @messages = @conversation.messages
    @message = Message.new
  end
  def invite
    @conversation = Conversation.find(params[:id])
    @conversation.users << User.find_by_name(params[:user]) 

    render json: {msg: "#{params[:user]} added!"}
  end
  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

  def interlocutor(conversation)
    conversation.users.include?(current_user) ? conversation.sender : conversation.users
  end
end
