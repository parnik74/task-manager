class AddDeletedAtToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :deleted_at, :timestamp
  end
end
