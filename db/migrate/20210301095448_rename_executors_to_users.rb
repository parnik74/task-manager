class RenameExecutorsToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_table :executors, :users
  end
end
