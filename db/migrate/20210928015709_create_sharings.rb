class CreateSharings < ActiveRecord::Migration[6.1]
  def change
    create_table :sharings do |t|
      t.references :note, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :permission, default: 0

      t.timestamps
    end
  end
end
