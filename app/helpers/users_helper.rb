module UsersHelper
  def conversation_interlocutor(conversation)
    conversation.users.include?(current_user) ? conversation.sender : current_user
  end
end
