class ActivityController < ApplicationController

  def show
    @show_join_activity_flag = true
    @activity = Activity.find_by(id: params[:id])
    @activity_user = ActivityUser.new
    @activity_user.activity_id = @activity.id
  end

  def join
    au_params = params.require(:activity_user).permit(:user_name, :activity_id, :phone)
    @activity = Activity.find_by(id: au_params[:activity_id])
    activity_u = ActivityUser.find_by(activity_id: au_params[:activity_id], phone: au_params[:phone])
    if activity_u.nil?
      ActivityUser.create(au_params)
      @show_message = {message: "报名成功!"}
    else
      @show_message = {message: "您已经报过名了!"}
    end

    respond_to do |format|
      format.js {return render :template => "activity/activity"}
    end
  end
end
