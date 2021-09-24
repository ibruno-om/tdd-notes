class CreateJoinTableNoteLabel < ActiveRecord::Migration[6.1]
  def change
    create_join_table :notes, :labels do |t|
      t.index %i[note_id label_id]
      t.index %i[label_id note_id]
    end
  end
end
