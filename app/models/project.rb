# frozen_string_literal: true

class Project < ApplicationRecord
  validates :name, presence: true
  has_many :tasks, dependent: :destroy
  belongs_to :executor
end
