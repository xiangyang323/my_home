class Home::ActivityController < HomeController

  def index

  end

  def list
    @head_title = "我的活动"
    @activities = Activity.where(user_id: current_user.id, check_flag: Activity::EDIT_FLAG)
  end

  def new
    if params[:id].blank?
      @head_title = "新建活动"
      @activity = Activity.find_or_create_by(check_flag: Activity::NEW_FLAG, user_id: current_user.id)
    else
      @head_title = "编辑活动"
      @activity = Activity.find_by(id: params[:id])
    end
    @show_address_flag = true
    # @brands = Brand.all
    if request.post?
      @activity.attributes = params.require(:activity).permit(:title, :phone, :start_time, :end_time)
      @activity.attributes = params.permit(:province, :city, :district, :detail_address)
      @activity.check_flag = Activity::EDIT_FLAG
      if !@activity.valid?
        flash[:notice] = @activity.errors.full_messages
        p flash[:notice]
      else
        @activity.save
        return redirect_to home_activity_list_path
      end
    end
  end

  def delete
    post = Post.find_by(id: params[:id])
    post.delete
    return redirect_to home_list_path
  end

  def upload_image
    if params[:image_id].blank? || params[:activity_id].blank?
      set_json_error({message: "params error"})
    else
      activity = Activity.find_by(id: params[:activity_id])
      activity.attributes = params.require(:activity).permit(params[:image_id], "#{params[:image_id]}_file_name", "#{params[:image_id]}_content_type", "#{params[:image_id]}_file_size", "#{params[:image_id]}_updated_at")
      activity.try(params[:image_id]).reprocess!
      if activity.valid?
        activity.transaction do
          activity.save
        end
        set_json_success({url: activity.try(params[:image_id]).url(:medium)})
      else
        set_json_error({message: activity.errors.full_messages.join(",")})
      end
    end

    respond_to do |format|
      format.json { render_to_json }
    end
  end
end