# frozen_string_literal: true

class Executor < ApplicationRecord
  validates :name, presence: true
  has_many :tasks
end
