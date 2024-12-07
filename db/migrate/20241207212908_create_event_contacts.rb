class CreateEventContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :event_contacts do |t|
      t.belongs_to :event, null: false, foreign_key: true
      t.string :name
      t.string :phone_number

      t.timestamps
    end
  end
end
