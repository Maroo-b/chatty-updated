class Conversation < ActiveRecord::Base
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  has_and_belongs_to_many :users

  has_many :messages, dependent: :destroy

  #validates_uniqueness_of :sender_id, :scope => :recipient_id

  scope :involving, -> (user) do
    where("conversations.sender_id =?",user.id) || joins(:users).where("users.id =?",user.id)
  end

  scope :between, -> (sender_id,recipient_ids) do
    (where("(conversations.sender_id = ?",sender_id) && joins(:users).where("users.id = ?",recipient_ids)) || 
    (where("conversations.sender_id  = ?",recipient_ids) && joins(:users).where( "users.id = ?",sender_id ) )
  end
end