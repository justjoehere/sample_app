module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end
  def current_user=(user)
    @current_user = user
  end
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
    #||= means if the @current_user is nil or undefefined, run the User.find_by function
    #otherwise, just use the @current_user as defined
  end
  def signed_in?
    !current_user.nil?
    #Means if current_user is not nil, return true.  If it is nil, return false
  end
  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil

  end
end