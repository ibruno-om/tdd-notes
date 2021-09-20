class CreateReminders < ActiveRecord::Migration[6.1]
  def change
    create_table :reminders do |t|
      t.references :note, null: false, foreign_key: true
      t.timestamp :notification_time

      t.timestamps
    end
  end
end
