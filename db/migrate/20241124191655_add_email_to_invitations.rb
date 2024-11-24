class AddEmailToInvitations < ActiveRecord::Migration[8.0]
  def change
    add_column :invitations, :email_address, :string
  end
end
