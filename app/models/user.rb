class User < ActiveRecord::Base

  def current_user
    self.find(session[:user])
  end

end
