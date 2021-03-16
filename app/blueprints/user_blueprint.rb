# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :id
  fields :name, :deleted_at
end
