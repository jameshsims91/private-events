class CreateEventAttendances < ActiveRecord::Migration[8.1]
  def change
    create_table :event_attendances do |t|
      t.references :attendee, null: false, foreign_key: { to_table: :users }
      t.references :attended_event, null: false, foreign_key: { to_table: :events }

      t.timestamps
    end
  end
end
