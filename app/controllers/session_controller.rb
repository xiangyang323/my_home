class SessionController < ApplicationController

  #http://www.jianshu.com/p/c525e4c18f5a
  def new
  end

  def create

  end

  def get_verification
    user = User.find_by(:phone, params[:phone])
    if user.nil?

    end
  end
end
