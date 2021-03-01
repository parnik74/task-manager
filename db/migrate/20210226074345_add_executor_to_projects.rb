class AddExecutorToProjects < ActiveRecord::Migration[6.0]
  def change
    add_reference :projects, :executor, foreign_key: true
  end
end
