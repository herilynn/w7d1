class ApplicationController < ActionController::Base
#used by all other controllers
#want to be able to find out if a user is logged_in
#someone is logged in if our session cookie has a session token key
#checking if the current session token matches our user
  #chr(r)lll
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  # 
  def login!(user)
    session[:session_token] = user.reset_session_token!
  end

  #in order ot log someone out we need to change their ST from the current one
  #We also need to tell our session cookie that it is nil
  #if the session token has a truthy value then they are loggedin - so we need to set it to nil 
  #we want to turn the @current_user to nil to clean up and end the response cycle

 
  def logged_in?  #can be signed-in
    !!current_user 
  end
  

  def logout!
    current_user.reset_session_token! if logged_in? 
    session[:session_token] = nil
    @current_user = nil
  end

  def require_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def require_logged_out
    redirect_to users_url if logged_in?
  end

end