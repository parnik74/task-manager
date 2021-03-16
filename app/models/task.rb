# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, presence: true
  belongs_to :project
  belongs_to :assignee, class_name: 'User'

  def soft_delete
    update(deleted_at: DateTime.current)
  end
end
