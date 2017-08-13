class Home::PostController < HomeController

  def index

  end

  def list
    @head_title = "我的展示"
    @posts = Post.where(check_flag: Post::EDIT_FLAG, user_id: current_user.id)
  end

  def new
    if params[:id].blank?
      @head_title = "新建活动"
      @post = Post.find_or_create_by(check_flag: Post::NEW_FLAG, user_id: current_user.id)
    else
      @head_title = "编辑活动"
      @post = Post.find_by(id: params[:id])
    end
    @brands = UserBrand.includes(:brand).where(user_id: current_user.id).map(&:brand)
    if request.post?
      @post.attributes = params.require(:post).permit(:title, :building, :province, :city, :district, :detail_address, :room_cnt, :living_room_cnt, :toilet_cnt, :kitchen_cnt, :home_size, :content1, :content2, :content3, :brand_ids)
      @post.check_flag = Post::EDIT_FLAG
      if !@post.valid?
        flash[:notice] = @post.errors.full_messages
        p flash[:notice]
      else
        @post.save
        return redirect_to home_post_list_path
      end
    end
  end

  def change_flag

  end

  def delete
    post = Post.find_by(id: params[:id], user_id: current_user.id)
    post.delete
    return redirect_to home_post_list_path
  end

  def upload_image
    if params[:image_id].blank? || params[:post_id].blank?
      set_json_error({message: "params error"})
    else
      post = Post.find_by(id: params[:post_id])
      post.attributes = params.require(:post).permit(params[:image_id], "#{params[:image_id]}_file_name", "#{params[:image_id]}_content_type", "#{params[:image_id]}_file_size", "#{params[:image_id]}_updated_at")
      post.try(params[:image_id]).reprocess!
      if post.valid?
        post.transaction do
          post.save
        end
        set_json_success({url: post.try(params[:image_id]).url(:medium)})
      else
        set_json_error({message: post.errors.full_messages.join(",")})
      end
    end

    respond_to do |format|
      format.json { render_to_json }
    end
  end
end