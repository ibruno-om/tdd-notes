# frozen_string_literal: true

class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :content
      t.string :color
      t.boolean :archived

      t.timestamps
    end
  end
end
