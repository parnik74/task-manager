# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable
  # validates :name, presence: true
  has_many :tasks, dependent: :restrict_with_exception

  def soft_delete
    update(deleted_at: DateTime.current)
  end
end
