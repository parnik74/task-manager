# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :status
      t.text :description
      t.datetime :due_time
      t.references :project, null: false, foreign_key: true
      t.references :executor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
