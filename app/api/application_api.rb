# frozen_string_literal: true

class ApplicationApi < Grape::API
  mount V1::Base
end
