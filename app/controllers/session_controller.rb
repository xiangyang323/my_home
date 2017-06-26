class SessionController < ApplicationController

  #http://www.jianshu.com/p/c525e4c18f5a
  def new
    @head_title = "登录"
    if !params[:session].nil? && !params[:session][:phone].blank?
      user = User.find_by(phone: params[:session][:phone])
      if user && BCrypt::Password.new(user.password_digest) == params[:session][:password]
        log_in(user) #SessionsHelper中的方法
        #判断是否要持续性的记住用户的登录状态
        params[:session][:remeber_me] == "1" ? remeber(user) : forget(user)
        p current_user
        redirect_to myhome_path
      else
        flash[:notice] = "密码或者手机号不对"
      end

    end
  end

  def create
    @head_title = "注册"
    if !params[:session].nil? && !params[:session][:verification_code].blank? && !params[:session][:phone].blank?
      user = User.find_by(phone: params[:session][:phone])
      if !user.nil?
        p user.verification_time
        p 20.minutes.ago
        if BCrypt::Password.new(user.verification_digest) == params[:session][:verification_code] && user.verification_time >= 20.minutes.ago
          user.password_digest = BCrypt::Password.create(params[:session][:password])
          user.is_verify = 1
          user.save
          log_in(user) #SessionsHelper中的方法
          p current_user
          redirect_to myhome_path
        else
          flash[:notice] = "验证码超时"
        end
      else
        flash[:notice] = "验证码不能匹配,请重新匹配"
      end
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
      if user.verification_time.to_date == Date.today
        return render json: {value: "已经验证超过三次了，明天继续", status: 3} if user.verification_limit > 2
      else
        user.verification_limit = 0
      end
    end
    user.verification_limit += 1
    verification_code = rand(1000..9999)
    user.verification_digest = BCrypt::Password.create(verification_code)
    user.verification_time = Time.now
    user.save
    return render json: {value: verification_code, status: 1}
  end

  def forget_password
    p current_user
    if !params[:session].nil? && !params[:session][:verification_code].blank? && !params[:session][:phone].blank?
      user = User.find_by(phone: params[:session][:phone])
      if !user.nil?
        p user.verification_time
        p 20.minutes.ago
        if BCrypt::Password.new(user.verification_digest) == params[:session][:verification_code] && user.verification_time >= 20.minutes.ago
          user.password_digest = BCrypt::Password.create(params[:session][:password])
          user.is_verify = 1
          user.save
          log_in(user) #SessionsHelper中的方法
          p current_user
          redirect_to root_path
        else
          flash[:notice] = "验证码超时"
        end
      else
        flash[:notice] = "验证码不能匹配,请重新匹配"
      end
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
