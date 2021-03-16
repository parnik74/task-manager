# frozen_string_literal: true

class TaskBlueprint < Blueprinter::Base
  identifier :id
  fields :name, :status, :description, :due_time, :project_id, :assignee_id, :deleted_at
end
