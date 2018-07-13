class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def current_user
  	puts "app cont"
  	puts session[:user_id]
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def login_url(user)
	puts "-----------------in login url-----------"
    session[:user_id] = user.id
    puts "login_url"
    puts session[:user_id]
  end
  def logout_url
  	puts "-------logout----"
    session.delete(:user_id)
    @current_user = nil
  end
end
