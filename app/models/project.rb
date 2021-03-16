# frozen_string_literal: true

class Project < ApplicationRecord
  validates :name, presence: true
  has_many :tasks, dependent: :destroy
  belongs_to :owner, class_name: 'User'

  def soft_delete
    update(deleted_at: DateTime.current)
  end
end
