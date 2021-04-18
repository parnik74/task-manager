# frozen_string_literal: true

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
    # User.find_by(id: session[:user_id]) || redirect_to(routes.login_url)
  end

  # reuse_access_token

  # skip_authorization do
  #   true
  # end
  # If you want to restrict access to the web interface for adding oauth authorized applications, you need to declare the block below.
  # admin_authenticator do
    # Put your admin authentication logic here.
    # Example implementation:
    # Admin.find_by_id(session[:admin_id]) || redirect_to(routes.login_url)
  # end

  # Define access token scopes for your provider
  # For more information go to
  # https://doorkeeper.gitbook.io/guides/ruby-on-rails/scopes
  #

  # optional_scopes :write, :update


  #=================================================================нужно
  skip_client_authentication_for_password_grant = true

  resource_owner_from_credentials do |routes|
    user = User.find_by_email(params[:username].downcase)
    puts "hello"
    # pp user
    if user && user.valid_password?(params[:password])
      pp user.valid_password?(params[:password])
      puts "hello"
      user
    end
  end
end
