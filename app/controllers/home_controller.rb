class HomeController < ApplicationController
  before_action :check_login#, except: :favorite

  def index
    @head_title = "我的页面"
  end

  def edit
    @head_title = "编辑"
    @user_profile = current_user.user_profile
    if request.post?
      @user_profile.attributes = params.require(:user_profile).permit(:user_name, :motto, :province, :city, :district, :detail_address)
      if !@user_profile.valid?
        flash[:notice] = @user_profile.errors.full_messages
        p flash[:notice]
      end
      @user_profile.save
    end
  end

  def upload_image
    up = UserProfile.find_by(user_id: current_user.id)

    up.attributes = params.require(:user_profile).permit(:avatar, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at)
    up.avatar.reprocess!

    respond_to do |format|
      if up.valid?
        up.transaction do
          up.save
        end
        set_json_success({url: up.avatar.url(:medium)})
      else
        set_json_error({message: up.errors.full_messages.join(",")})
      end
      format.json { render_to_json }
    end
  end

  def favorite
    uf = UserFavorite.find_by(user_id: current_user.id, post_id: params[:id])
    if uf.nil?
      UserFavorite.create(user_id: current_user.id, post_id: params[:id])
      set_json_success({value: "add"})
    else
      uf.delete
      set_json_success({value: "delete"})
    end

    respond_to do |format|
      format.json { render_to_json }
    end
  end

  private
  def check_login
    if !logged_in?
      redirect_to login_path
    end
  end
end
