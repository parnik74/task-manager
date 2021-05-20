# frozen_string_literal: true

require 'doorkeeper/grape/helpers'

class ApplicationApi < Grape::API
  before do
    doorkeeper_authorize!
  end

  # include V1::Helpers::Authentication
  helpers Doorkeeper::Grape::Helpers, Pundit
  helpers do
    def current_user
      return @current_user if defined?(@current_user)

      if doorkeeper_token.resource_owner_id.present?
        @current_user = User.find(doorkeeper_token.resource_owner_id)
      end
    end
  end
  mount V1::Base
end
