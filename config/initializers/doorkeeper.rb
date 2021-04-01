# frozen_string_literal: true

# OAUTH_SCOPES = [:read_user, :write_user].freeze
# OAUTH_SCOPES_S = OAUTH_SCOPES.join(' ')
Doorkeeper.configure do
  # Change the ORM that doorkeeper will use (requires ORM extensions installed).
  # Check the list of supported ORMs here: https://github.com/doorkeeper-gem/doorkeeper#orms
  # orm :active_record
  grant_flows %w[password]
  resource_owner_authenticator do
    if user = UserSession.find.try(:record)
      user
    else
      session[:return_to] = request.url
      redirect_to(auth_sign_in_url)
    end
    # current_user || warden.authenticate!(:scope => :user) # Not sure
    # User.find_by(id: session[:user_id]) || redirect_to(new_user_session_url)
  end

  reuse_access_token

  skip_authorization do
    true
  end

  resource_owner_from_credentials do |routes|
    user = User.find_by_email(params[:username].downcase)
    puts "hello"
    if user && user.valid_password?(params[:password])
      pp user.valid_password?(params[:password])
      puts "hello"
      user
    end
  end
end
