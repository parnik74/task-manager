# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true
  has_many :tasks

  def soft_delete
    update(deleted_at: DateTime.current)
  end
end
