class AddMuteToUser < ActiveRecord::Migration
  def change
    add_column :users, :mute, :boolean
  end
end
