# frozen_string_literal: true

class TaskBlueprint < Blueprinter::Base
  identifier :id
  fields :name, :description, :status, :project_id, :executor_id
end
