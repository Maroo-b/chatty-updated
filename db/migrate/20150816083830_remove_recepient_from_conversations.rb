class RemoveRecepientFromConversations < ActiveRecord::Migration
  def change
    remove_column :conversations, :recipient_id, :integer
  end
end
