module V1
  module Helpers
    module Authentication
      def current_user
        return @current_user if defined?(@current_user)

        if doorkeeper_token&.resource_owner_id&.present?
          @current_user = User.find(doorkeeper_token.resource_owner_id)
        end
      end
    end
  end
end
