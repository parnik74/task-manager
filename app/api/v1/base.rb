# frozen_string_literal: true

module V1
  class Base < Grape::API
    mount V1::Projects
    mount V1::Tasks
    mount V1::Users
  end
end
