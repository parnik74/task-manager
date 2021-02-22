# frozen_string_literal: true

class ProjectBlueprint < Blueprinter::Base
  identifier :id
  fields :name, :description, :status
end
