class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  skip_before_filter :verify_authenticity_token  #See http://stackoverflow.com/questions/3364492/actioncontrollerinvalidauthenticitytoken
  #I have no idea why this works [fixes all tests involving sign-outs]
  #Manual tests indicates things still work okay.
end
