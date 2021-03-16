# frozen_string_literal: true

class ProjectBlueprint < Blueprinter::Base
  identifier :id
  fields :name, :description, :status, :owner, :deleted_at
end
