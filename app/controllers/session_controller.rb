class SessionController < ApplicationController

  #http://www.jianshu.com/p/c525e4c18f5a
  def new
  end

  def create
    login = params[:session][:login]
    password = params[:session][:password]

    #User.find_by_login(login)是新增加的一个类方法，用来实现name或者email的登录
    user = User.find_by_login(login)
    #authenticate是has_secure_password引入的一个方法，用来判断user的密码与页面中传过来的密码是否一致
    if user && user.authenticate(password)
      log_in(user) #SessionsHelper中的方法
      #判断是否要持续性的记住用户的登录状态
      params[:session][:remeber_me] == "1" ? remeber(user) : forget(user)
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Invalid login or password."
      render 'new'
    end

  end

  def get_verification
    phone_match = params[:phone].match(/^1[3|4|5|8][0-9]\d{4,8}$/)
    if phone_match.nil?
      return render json: {value: "电话号码异常", status: 0}
    end
    user = User.find_by(phone: params[:phone])
    if user.nil?
      user = User.new
      user.phone = params[:phone]
    else
      if user.is_verify?
        return render json: {value: "手机号码已经存在", status: 2}
      else
        if user.verification_time.to_date == Date.today
          return render json: {value: "已经验证超过三次了，明天继续", status: 3} if user.verification_limit > 2
        else
          user.verification_limit = 0
        end
      end
    end
    user.verification_limit += 1
    user.verification_code = rand(1000..9999)
    user.verification_time = Time.now
    user.save
    return render json: {value: user.verification_code, status: 1}
  end
end
