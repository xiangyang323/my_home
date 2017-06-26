class HomeController < ApplicationController
  before_action :check_login

  def index
    @head_title = "我的页面"
  end

  def edit
    @head_title = "编辑"
  end

  private
  def check_login
    if !logged_in?
      redirect_to login_path
    end
  end
end
