class AddUserIdToInvitations < ActiveRecord::Migration[8.0]
  def change
    add_reference :invitations, :user, foreign_key: true, index: true
  end
end
