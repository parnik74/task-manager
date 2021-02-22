# frozen_string_literal: true

class CreateExecutors < ActiveRecord::Migration[6.0]
  def change
    create_table :executors do |t|
      t.string :name

      t.timestamps
    end
  end
end
