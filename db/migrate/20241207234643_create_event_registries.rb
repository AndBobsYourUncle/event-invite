class CreateEventRegistries < ActiveRecord::Migration[8.0]
  def change
    create_table :event_registries do |t|
      t.belongs_to :event, null: false, foreign_key: true
      t.string :name
      t.string :link

      t.timestamps
    end
  end
end
