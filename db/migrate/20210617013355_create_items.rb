# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :description
      t.references :note, null: false, foreign_key: true

      t.timestamps
    end
  end
end
