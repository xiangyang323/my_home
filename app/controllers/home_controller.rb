class HomeController < ApplicationController
  before_action :check_login

  def index

  end


  private
  def check_login
    if !logged_in?
      redirect_to login_path
    end
  end
end
