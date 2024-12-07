class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :event_time
      t.string :location
      t.string :address_1
      t.string :city
      t.string :state
      t.string :zip
      t.datetime :rsvp_by

      t.timestamps
    end
  end
end
