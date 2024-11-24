class CreateInvitations < ActiveRecord::Migration[8.0]
  def change
    create_table :invitations do |t|
      t.string :full_name, null: false
      t.string :invite_code, null: false

      t.timestamps
    end
    add_index :invitations, :invite_code, unique: true
  end
end
