module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end


  def signed_in?
    !current_user.nil?   #presume the ! is a 'not' here
  end

  def current_user=(user)   #the = immendiately after method name includes it i nmethod name and makes it an assign function
    @current_user = user     #? this code i find a bit fuzy
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)   
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url   #? session is like an instance of the  cookie variable .. but is stored on server or host's browser params?
  end

end
