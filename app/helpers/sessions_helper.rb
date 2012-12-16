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

end
