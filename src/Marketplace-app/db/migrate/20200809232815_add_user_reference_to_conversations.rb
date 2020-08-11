class AddUserReferenceToConversations < ActiveRecord::Migration[6.0]
  def change
    add_reference :conversations, :user, foreign_key: true
  end
end
