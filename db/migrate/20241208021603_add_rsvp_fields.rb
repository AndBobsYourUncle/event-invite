class AddRsvpFields < ActiveRecord::Migration[8.0]
  def change
    add_column :invitations, :rsvp_answer, :integer, default: 0
    add_column :invitations, :rsvp_count, :integer
  end
end
